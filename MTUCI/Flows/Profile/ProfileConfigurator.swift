// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import NetworkKit

final class ProfileConfigurator {

    private let services: ApplicationServices
    private let stubBehavior: StubBehavior

    init(isStubbed: Bool, services: ApplicationServices) {
        self.stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
        self.services = services
    }

    func create(router: ProfileRouter, userId: String, role: AuthResponse.Role) -> UIViewController {
        let interactor = ProfileInteractor(services: services, stubBehavior: stubBehavior, userId: userId, role: role)
        let presenter = ProfilePresenter()
        let view = ProfileView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
