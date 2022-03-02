// Created by Anatoly Qstove on 01.03.2022.

import NavigationKit
import UIKit
import NetworkKit

protocol LoginCoordinatorOutput: AnyObject {
    func loginCoordinatorDidFinish(person: AuthResponse.Person, _ coordinator: LoginCoordinator)
}

final class LoginCoordinator: NavigationCoordinator<LoginCoordinator.Route> {
    enum Route {
        case login
        case flowPlaceholder
    }

    private let services: ApplicationServices
    private let isStubbed: Bool
    weak var output: LoginCoordinatorOutput?

    init(
        rootViewController: UINavigationController,
        services: ApplicationServices,
        isStubbed: Bool
    ) {
        self.services = services
        self.isStubbed = isStubbed
        super.init(rootViewController: rootViewController)
    }

    override func prepareTransition(for route: Route) -> NavigationTransition {
        switch route {
        case .login:
            let module = LoginConfigurator(isStubbed: isStubbed, services: services).create(router: self)
            return .push(module)
        case .flowPlaceholder:
            let module = UIViewController()
            return .push(module)
        }
    }

    override func start() {
        trigger(route: .login)
    }
}

extension LoginCoordinator: LoginRouter {
    func route(output: LoginModule.Output) {
        switch output {
        case .main(let person):
            self.output?.loginCoordinatorDidFinish(person: person, self)
        }
    }
}
