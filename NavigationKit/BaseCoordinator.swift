// Created by Aleksandr Belbakov on 01.09.2021.

import UIKit

open class BaseCoordinator<RouteType, TransitionType: TransitionProtocol>: Coordinator {

    public var rootViewController: TransitionType.RootViewController

    // MARK: - Presentable

    public var viewController: UIViewController {
        rootViewController
    }

    // MARK: - Router

    public func trigger(route: RouteType) {
        let transition = prepareTransition(for: route)
        performTransition(transition, completion: nil)
    }

    public func performTransition(_ transition: TransitionType, completion: PresentationHandler?) {
        transition.perform(on: rootViewController, completion: nil)
    }

    private var children: [Presentable]

    init(rootViewController: TransitionType.RootViewController) {
        self.rootViewController = rootViewController
        children = []
    }

    public func add(child: Presentable) {
        children.append(child)
    }

    public func remove(child: Presentable) {
        children.removeAll(where: { $0 === child })
    }

    public func cleanup() {
        assertionFailure()
    }

    open func prepareTransition(for route: RouteType) -> TransitionType {
        fatalError("Not implemented")
    }

    open func start() {
        fatalError("Not implemented")
    }
}
