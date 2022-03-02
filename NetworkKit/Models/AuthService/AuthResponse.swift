// Created by Anatoly Qstove on 02.03.2022.

import Foundation

public struct AuthResponse: Codable {
    public let token: String
    public let person: Person

    public struct Person: Codable {
        public let id: String
        public let role: String
        public let firstName: String
        public let lastName: String
        public let middleName: String
        public let isActive: Bool
    }
}
