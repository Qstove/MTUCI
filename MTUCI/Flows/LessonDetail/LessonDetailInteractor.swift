// Created by Anatoly Qstove on 06.03.2022.

import Foundation
import NetworkKit

final class LessonDetailInteractor: LessonDetailInteractorInput {

    var presenter: LessonDetailPresenterInput?
    private let userId: String
    private let role: AuthResponse.Role
    private let lessonModel: ScheduleResponse.Lesson
    private let services: ApplicationServices
    private let stubBehavior: NetworkKit.StubBehavior

    init(
        services: ApplicationServices,
        stubBehavior: NetworkKit.StubBehavior,
        userId: String,
        role: AuthResponse.Role,
        lessonModel: ScheduleResponse.Lesson
    ) {
        self.services = services
        self.stubBehavior = stubBehavior
        self.userId = userId
        self.role = role
        self.lessonModel = lessonModel
    }

    func load() {
        let response = LessonDetailModule.UseCase.Load.Response(lesson: lessonModel, role: role)
        presenter?.present(response)
    }
}
