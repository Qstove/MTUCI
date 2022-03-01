// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import CoreKit

public enum Endpoint: CaseIterable, Codable {
    case test
    case preProd
    case prod

    public var url: String {
        switch self {
        case .test:
            return "https://dbofltest.domrfbank.ru/api/"
        case .preProd:
            return "https://dbofl-test.domrfbank.ru/api/"
        case .prod:
            return "https://dbofltest4.domrfbank.ru/api/"
        }
    }

    public var name: String {
        switch self {
        case .test:
            return "Тест"
        case .preProd:
            return "Препрод"
        case .prod:
            return "Прод"
        }
    }

    public static var `default`: Endpoint {
        .preProd
    }

    /// Used by MoyaTarget to stisfy protocol requirement for baseURL.
    internal static var current: Endpoint {
        return Preferences().get(for: ApplicationPreferencesKey.endpoint) ?? Endpoint.default
    }
}
