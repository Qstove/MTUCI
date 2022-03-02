// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NavigationKit

protocol SheduleCoordinatorOutput: AnyObject {
    func sheduleCoordinatorDidFinish(_ coordinator: SheduleCoordinator)
}

class SheduleCoordinator: NavigationCoordinator<SheduleCoordinator.Route> {
    enum Route {
        case shedule
        case flowPlaceholder
    }

    private let services: ApplicationServices
    private let isStubbed: Bool
    weak var output: SheduleCoordinatorOutput?

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
        case .shedule:
            break
        case .flowPlaceholder:
            break
        }
    }

    override func start() {
        trigger(route: .shedule)
    }

}