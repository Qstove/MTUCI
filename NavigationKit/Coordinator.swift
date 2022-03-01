// Created by Aleksandr Belbakov on 08.09.2021.

import Foundation

public protocol Coordinator: Router, TransitionPerformer {
    func add(child: Presentable)
    func remove(child: Presentable)
    func cleanup()
    func prepareTransition(for route: RouteType) -> TransitionType
    func start()
}
