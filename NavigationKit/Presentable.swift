// Created by Aleksandr Belbakov on 03.09.2021.

import UIKit

public protocol Presentable: AnyObject {
    var viewController: UIViewController { get }
}

extension UIViewController: Presentable {
    public var viewController: UIViewController {
        return self
    }
}
