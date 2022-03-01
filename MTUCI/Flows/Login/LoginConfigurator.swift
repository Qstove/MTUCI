// Created by Anatoly Qstove on 01.03.2022.

import UIKit
import NetworkKit

final class LoginConfigurator {

    private let services: ApplicationServices
    private let stubBehavior: StubBehavior
    
    init(isStubbed: Bool, services: ApplicationServices) {
        self.stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
        self.services = services
    }

    func create(router: LoginRouter) -> UIViewController {
        let interactor = LoginInteractor(services: services, stubBehavior: stubBehavior)
        let presenter = LoginPresenter()
        let view = LoginView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
