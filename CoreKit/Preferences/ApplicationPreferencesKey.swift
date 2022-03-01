// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public enum ApplicationPreferencesKey: String, PreferencesKey {
    case lastLaunch
    case endpoint
    case authenticated
    case savedLogin
    case authKey

    public var description: String {
        rawValue
    }
}
