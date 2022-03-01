// Created by Aleksandr Belbakov on 07.09.2021.

import Foundation

public protocol TransitionPerformer: Presentable {
    typealias PresentationHandler = () -> Void

    associatedtype TransitionType: TransitionProtocol

    var rootViewController: TransitionType.RootViewController { get }

    func performTransition(_ transition: TransitionType, completion: PresentationHandler?)
}
