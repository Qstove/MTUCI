// Created by Aleksandr Belbakov on 08.09.2021.

import Foundation

open class NavigationCoordinator<RouteType>: BaseCoordinator<RouteType, NavigationTransition> {
    public override init(rootViewController: TransitionType.RootViewController) {
        super.init(rootViewController: rootViewController)
    }
}
