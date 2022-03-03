// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NetworkKit
import NavigationKit

protocol ProfileCoordinatorOutput: AnyObject {
    func profileCoordinatorDidFinish(_ coordinator: ProfileCoordinator)
}

final class ProfileCoordinator: NavigationCoordinator<ProfileCoordinator.Route> {
    enum Route {
        case profile
//        case flowPlaceholder
    }
    weak var output: ProfileCoordinatorOutput?

    private let services: ApplicationServices
    private let isStubbed: Bool
    private let person: AuthResponse.Person

    init(
        rootViewController: UINavigationController,
        services: ApplicationServices,
        isStubbed: Bool,
        person: AuthResponse.Person
    ) {
        self.services = services
        self.isStubbed = isStubbed
        self.person = person
        super.init(rootViewController: rootViewController)
    }

    override func prepareTransition(for route: Route) -> NavigationTransition {
        switch route {
        case .profile:
            let module = ProfileConfigurator(isStubbed: isStubbed, services: services).create(router: self, userId: person.id, role: person.role)
            return .push(module)
//        case .flowPlaceholder:
//            break
        }
    }

    override func start() {
        trigger(route: .profile)
    }
}

extension ProfileCoordinator: ProfileRouter {
    func route(output: ProfileModule.Output) {
        
    }


}
