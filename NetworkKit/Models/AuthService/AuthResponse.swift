// Created by Anatoly Qstove on 02.03.2022.

import Foundation

public struct AuthResponse: Codable {
    public let token: String
    public let person: Person

    public struct Person: Codable {
        public let id: String
        public let role: Role
        public let isActive: Bool
    }

    public enum Role: String, Codable {
        case teacher = "TEACHER"
        case student = "STUDENT"
    }
}
