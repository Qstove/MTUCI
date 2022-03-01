// Created by Aleksandr Belbakov on 08.09.2021.

import Foundation

public protocol Router {
    associatedtype RouteType
    func trigger(route: RouteType)
}
