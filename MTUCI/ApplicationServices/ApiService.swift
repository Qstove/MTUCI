// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import Moya
import NetworkKit
import CoreKit

public final class ApiService {
    @KeychainStored(ApplicationKeychainGroup.initialAuthTokenKey)
    private var authToken: String?

    public func provider<Target: TargetType>(for service: Target.Type, stubBehavior: NetworkKit.StubBehavior = .never) -> MoyaProvider<Target> {
        MoyaProvider(stubClosure: stubBehavior.closure(), plugins: [AuthTokenPlugin(token: authToken ?? "")])
    }
}
