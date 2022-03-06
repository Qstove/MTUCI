// Created by Anatoly Qstove on 06.03.2022.

import UIKit
import NetworkKit

final class LessonDetailConfigurator {

    private let services: ApplicationServices
    private let stubBehavior: StubBehavior

    init(isStubbed: Bool, services: ApplicationServices) {
        self.stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
        self.services = services
    }

    func create(
        router: LessonDetailRouter,
        userId: String,
        role: AuthResponse.Role,
        lessonModel: ScheduleResponse.Lesson
    ) -> UIViewController {
        let interactor = LessonDetailInteractor(
            services: services,
            stubBehavior: stubBehavior,
            userId: userId,
            role: role,
            lessonModel: lessonModel
        )
        let presenter = LessonDetailPresenter()
        let view = LessonDetailView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
