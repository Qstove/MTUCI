// Created by Anatoly Qstove on 04.03.2022.

import Foundation

public struct ScheduleResponse: Codable {
    public let days: [Day]

    public struct Day: Codable {
        public let name: String
        public let date: String
        public let lessons: [Lesson]
    }

    public struct Lesson: Codable {
        public let discipline: String
        public let teacher: String
        public let group: String
        public let type: String
        public let timeStart: String
        public let timeEnd: String
        public let auditory: String
        public let comments: String?
        public let linkForRemote: String?
    }
}

