// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NavigationKit

protocol NewsCoordinatorOutput: AnyObject {
    func newsCoordinatorDidFinish(_ coordinator: NewsCoordinator)
}

final class NewsCoordinator: NavigationCoordinator<NewsCoordinator.Route> {
    enum Route {
        case news
//        case flowPlaceholder
    }

    private let services: ApplicationServices
    private let isStubbed: Bool
    weak var output: NewsCoordinatorOutput?

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
        case .news:
            let module = NewsConfigurator(isStubbed: isStubbed, services: services).create(router: self)
            return .push(module)
//        case .flowPlaceholder:
//            break
        }
    }

    override func start() {
        trigger(route: .news)
    }
}

extension NewsCoordinator: NewsRouter {
    func route(output: NewsModule.Output) {

    }
}
