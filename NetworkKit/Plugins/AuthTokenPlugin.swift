// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import Moya

public struct AuthTokenPlugin: PluginType {

    private let token: String

    public init(token: String) {
        self.token = token
    }

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.cachePolicy = .reloadIgnoringCacheData
        request.addValue(token, forHTTPHeaderField: "authToken")
        return request
    }
}
