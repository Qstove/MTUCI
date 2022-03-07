// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import Moya

public enum ScheduleService {
    case schedule(userId: String, role: AuthResponse.Role)
}

extension ScheduleService: TargetType {

    public var path: String {
        switch self {
        case .schedule(let id, let role):
            return "mtuci/api/shedule/\(role)/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .schedule:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .schedule:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        return nil
    }

    public var sampleData: Data {
        switch self {
        case .schedule(_, let role):
            switch role {
            case .teacher :
                return sample(from: "schedule-teacher-200", ofExtension: "json")
            case .student:
                return sample(from: "schedule-student-200", ofExtension: "json")
            }
        }
    }
}
