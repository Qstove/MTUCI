// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public struct KeychainPassword: KeychainQueryable {
    public let service: String?
    public let account: String?

    public init(
        service: String? = nil,
        account: String? = nil
    ) {
        self.service = service
        self.account = account
    }

    public var attributes: [String: Any] {
        var result: [String: Any] = [:]
        result[kSecClass as String] = kSecClassGenericPassword
        result[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        result[kSecAttrService as String] = service
        result[kSecAttrAccount as String] = account
        return result
    }

    public var lookupAttributes: [String : Any] {
        var result = attributes
        result[kSecAttrAccessible as String] = nil
        return result
    }

    public var updateAttributes: [String : Any] {
        var result = attributes
        result[kSecAttrAccessible as String] = nil
        result[kSecClass as String] = nil
        return result
    }
}
