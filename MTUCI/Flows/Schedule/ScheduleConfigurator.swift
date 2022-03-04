// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import NetworkKit

final class ScheduleConfigurator {

    private let services: ApplicationServices
    private let stubBehavior: StubBehavior

    init(isStubbed: Bool, services: ApplicationServices) {
        self.stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
        self.services = services
    }

    func create(router: ScheduleRouter, userId: String, role: AuthResponse.Role) -> UIViewController {
        let interactor = ScheduleInteractor(services: services, stubBehavior: stubBehavior, userId: userId, role: role)
        let presenter = SchedulePresenter()
        let view = ScheduleView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
