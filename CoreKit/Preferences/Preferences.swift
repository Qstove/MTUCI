// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public class Preferences {
    
    private let storage: UserDefaults

    public init(storage: UserDefaults = .standard) {
        self.storage = storage
    }

    public func set<Value: Codable>(_ value: Value, for key: PreferencesKey) {
        if let dictionary = try? PropertyListEncoder().encode(value) {
            storage.set(dictionary, forKey: key.description)
        } else {
            storage.set(value, forKey: key.description)
        }
    }

    public func get<Value: Codable>(for key: PreferencesKey) -> Value? {
        if let data = storage.value(forKey: key.description) as? Data,
           let value = try? PropertyListDecoder().decode(Value.self, from: data) {
            return value
        } else {
            return storage.value(forKey: key.description) as? Value
        }
    }
}
