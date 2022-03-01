// Created by Anatoly Qstove on 01.03.2022.

import Foundation

@propertyWrapper
public struct KeychainStored<Value: Codable> {

    public let query: KeychainQueryable

    public init(query: KeychainQueryable) {
        self.query = query
    }

    public init(_ group: KeychainGroup) {
        self.query = group.item
    }

    public var wrappedValue: Value? {
        get {
            let keychain = Keychain()
            return try? keychain.get(query)
        }
        set {
            let keychain = Keychain()
            try? keychain.set(newValue, for: query)
        }
    }
}
