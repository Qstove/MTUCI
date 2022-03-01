// Created by Aleksandr Belbakov on 07.09.2021.

import UIKit

public protocol TransitionProtocol {
    associatedtype RootViewController: UIViewController

    typealias PresentationHandler = () -> Void
    
    func perform(on rootViewController: RootViewController, completion: PresentationHandler?)
}

public struct Transition<RootViewController: UIViewController>: TransitionProtocol {
    public typealias PerformClosure = (_ rootViewController: RootViewController, _ completion: PresentationHandler?) -> Void

    private var _presentables: [Presentable]
    private var _perform: PerformClosure

    public init(presentables: [Presentable], perform: @escaping PerformClosure) {
        self._presentables = presentables
        self._perform = perform
    }

    public func perform(on rootViewController: RootViewController, completion: PresentationHandler?) {
        _perform(rootViewController, completion)
    }
}

extension Transition {
    public static var none: Transition {
        Transition(presentables: [], perform: { _, _ in })
    }
}

// MARK: - Navigation Transition

public typealias NavigationTransition = Transition<UINavigationController>

extension Transition where RootViewController: UINavigationController {
    public static func push(_ presentable: Presentable) -> Transition {
        Transition(presentables: [presentable]) { rootViewController, completion in
            rootViewController.viewControllers.last?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            rootViewController.pushViewController(presentable.viewController, animated: true)
        }
    }

    public static func pop() -> Transition {
        Transition(presentables: []) { rootViewController, completion in
            rootViewController.popViewController(animated: true)
        }
    }

    public static func popToRoot() -> Transition {
        Transition(presentables: []) { rootViewController, completion in
            rootViewController.popToRootViewController(animated: true)
        }
    }

    public static func pop<T>(to presentable: T.Type) -> Transition where T: Presentable {
        Transition(presentables: []) { rootViewController, completion in
            guard let viewController = rootViewController.viewControllers.first(where: { $0 is T }) else { return }
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                completion?()
            }
            rootViewController.popToViewController(viewController, animated: true)
            CATransaction.commit()
        }
    }

    public static func replace(_ presentable: Presentable) -> Transition {
        Transition(presentables: [presentable]) { rootViewController, completion in
            var viewControllers: [UIViewController] = rootViewController.viewControllers.dropLast()
            viewControllers.append(presentable.viewController)
            rootViewController.setViewControllers(viewControllers, animated: true)
        }
    }

    public static func replace<T>(_ presentable: Presentable, from: T.Type) -> Transition {
        Transition(presentables: [presentable]) { rootViewController, completion in
            guard let index = rootViewController.viewControllers.lastIndex(where: { $0 is T }) else { return }
            var viewControllers: [UIViewController] = rootViewController.viewControllers.dropLast(rootViewController.viewControllers.count - index)
            viewControllers.append(presentable.viewController)
            rootViewController.setViewControllers(viewControllers, animated: true)
        }
    }
}

// MARK: - Present Transition

extension Transition where RootViewController: UIViewController {

    public static func present(_ presentable: Presentable) -> Transition {
        Transition(presentables: [presentable]) { rootViewController, completion in
            rootViewController.present(presentable.viewController, animated: true, completion: completion)
        }
    }
}

// MARK: - Multiple

extension Transition {
    public static func multiple<C: Collection>(_ transitions: C) -> Transition where C.Element == Transition {
        Transition(presentables: []) { rootViewController, completion in
            guard let first = transitions.first else {
                completion?()
                return
            }
            first.perform(on: rootViewController) {
                let transitions = transitions.dropFirst()
                Transition
                    .multiple(transitions)
                    .perform(on: rootViewController, completion: completion)
            }
        }
    }
}
