// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import Moya

public enum AuthService {
    case login(username: String, password: String)
}

extension AuthService: TargetType {

    public var path: String {
        switch self {
        case .login:
            return "v1/auth/login"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case .login(let username, let password):
            var parameters = [String: Any]()
            parameters["username"] = username
            parameters["password"] = password
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return nil
    }

    public var sampleData: Data {
        return Data()
    }
}
