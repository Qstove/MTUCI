// Created by Anatoly Qstove on 03.03.2022.

import Foundation

public struct ProfileTeacherResponse: Codable {
    public let profile: Profile

    public struct Profile: Codable {
        public let firstName: String
        public let lastName: String
        public let middleName: String
        public let gender: String
        public let photoUrl: String?
        public let department: String
        public let contacts: Contacts
    }

    public struct Contacts: Codable {
        public let email: String
        public let phone: String?
        public let telegram: String?
    }
}
