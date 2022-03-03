// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import Moya

public enum ProfileService {
    case profile(userId: String, role: String)
}

extension ProfileService: TargetType {

    public var path: String {
        switch self {
        case .profile(let id, let role):
            return "mtuci/api/profile/\(role)/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .profile:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .profile:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        return nil
    }

    public var sampleData: Data {
        switch self {
        case .profile(let userId, _):
            switch userId {
            case "0":
                return sample(from: "profile-teacher-200", ofExtension: "json")
            case "1":
                return sample(from: "profile-student-200", ofExtension: "json")
            default:
                return Data()
            }
        }
    }
}
