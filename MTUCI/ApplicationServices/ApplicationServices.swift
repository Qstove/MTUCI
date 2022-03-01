// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import CoreKit
import NetworkKit
import Moya

/// Протокол, описывающий все зависимости системы.
/// Создан для отказа от DI framework в пользу концепции Composition Root.
///
/// Причины отказа от DI:
/// 1. Использовать меньше сторонних зависимостей для простого согласования приложения со службой безопасности
/// 2. Уменьшение количества ошибок/крашей приложения, т.к. используется строгая типизация для каждой зависимости
///
/// Прочитать про концепцию можно в [статье](https://blog.ploeh.dk/2011/07/28/CompositionRoot/)
public protocol ApplicationServices {
    var endpoint: NetworkKit.Endpoint { get set }
    var api: ApiService { get }
    var authService: AuthorizationService { get }
}

/// Реализация ApplicationServices
public final class DefaultApplicationServices: ApplicationServices {

    @PreferencesStored(key: ApplicationPreferencesKey.endpoint)
    public var endpoint: NetworkKit.Endpoint = Endpoint.default

    public var api: ApiService {
        ApiService()
    }

    public var authService: AuthorizationService {
        AuthorizationService(keychain: Keychain())
    }
}
