// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NavigationKit

protocol ProfileCoordinatorOutput: AnyObject {
    func profileCoordinatorDidFinish(_ coordinator: ProfileCoordinator)
}

final class ProfileCoordinator: NavigationCoordinator<ProfileCoordinator.Route> {
    enum Route {
        case profile
//        case flowPlaceholder
    }

    private let services: ApplicationServices
    private let isStubbed: Bool
    weak var output: ProfileCoordinatorOutput?

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
        case .profile:
            let module = ProfileConfigurator(isStubbed: isStubbed, services: services).create(router: self)
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
