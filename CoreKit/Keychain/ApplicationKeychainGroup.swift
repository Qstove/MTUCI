// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public enum ApplicationKeychainGroup: String, KeychainGroup {
    case initialAuthKey
    case initialAuthTokenKey
    case confirmTokenKey
    case biometricsDomainState
    case uniqueDeviceID
    case passcodeKey

    public var item: KeychainQueryable {
        KeychainPassword(service: Bundle.main.bundleIdentifier, account: rawValue)
    }

    public static var group: KeychainQueryable {
        KeychainPassword(service: Bundle.main.bundleIdentifier)
    }
}
