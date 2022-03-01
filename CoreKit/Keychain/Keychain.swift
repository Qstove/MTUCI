// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public final class Keychain {
    public let accessGroup: String?

    public init(accessGroup: String? = nil) {
        self.accessGroup = accessGroup
    }

    public func contains(_ queryable: KeychainQueryable) throws -> Bool {
        var params = queryable.lookupAttributes
        params[kSecMatchLimit as String] = kSecMatchLimitOne
        let status = SecItemCopyMatching(params as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainError.securityError(status: status)
        }
    }

    public func remove(_ queryable: KeychainQueryable) throws {
        let status = SecItemDelete(queryable.lookupAttributes as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            throw KeychainError.securityError(status: status)
        }
    }

    public func get<Value: Decodable>(_ queryable: KeychainQueryable) throws -> Value {
        let data = try data(for: queryable)
        return try JSONDecoder().decode(Value.self, from: data)
    }

    public func set<Value: Encodable>(_ value: Value?, for queryable: KeychainQueryable) throws {
        let data = try JSONEncoder().encode(value)
        try setData(data, for: queryable)
    }

    private func data(for queryable: KeychainQueryable) throws -> Data {
        var params = queryable.lookupAttributes
        params[kSecMatchLimit as String] = kSecMatchLimitOne
        params[kSecReturnData as String] = kCFBooleanTrue
        var itemRef: CFTypeRef?
        let status = SecItemCopyMatching(params as CFDictionary, &itemRef)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard let data = itemRef as? Data else {
            throw KeychainError.invalidItemFormat
        }

        return data
    }

    private func setData(_ data: Data?, for queryable: KeychainQueryable) throws {
        var params = queryable.lookupAttributes
        params[kSecMatchLimit as String] = kSecMatchLimitOne
        let status = SecItemCopyMatching(params as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            var attributes = queryable.updateAttributes
            attributes[kSecValueData as String] = data as Any
            let status = SecItemUpdate(
                queryable.lookupAttributes as CFDictionary,
                attributes as CFDictionary)
            
            guard status == errSecSuccess else {
                throw KeychainError.securityError(status: status)
            }
        case errSecItemNotFound:
            var params = queryable.attributes
            params[kSecValueData as String] = data
            let status = SecItemAdd(params as CFDictionary, nil)

            guard status == errSecSuccess else {
                throw KeychainError.securityError(status: status)
            }
        default:
            throw KeychainError.securityError(status: status)
        }
    }
}
