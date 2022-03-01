// Created by Anatoly Qstove on 01.03.2022.

import Foundation

@propertyWrapper
public struct PreferencesStored<Value: Codable> {
    
    private let defaultValue: Value
    private let key: PreferencesKey
    private let storage: Preferences

    public init(wrappedValue defaultValue: Value, key: PreferencesKey, storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = Preferences(storage: storage)
    }

    public var wrappedValue: Value {
        get {
            storage.get(for: key) ?? defaultValue
        }
        set {
            storage.set(newValue, for: key)
        }
    }
}
