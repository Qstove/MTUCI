// Created by Anatoly Qstove on 06.03.2022.

import Foundation
import UIKit

final class SpinnerView: UIView {
    private let spinner = UIActivityIndicatorView.init(style: .large)

    public func start(on view: UIView) {
        backgroundColor = .black.withAlphaComponent(0.75)
        view.addSubview(self)
        frame = view.bounds
        spinner.color = .white
        spinner.center = center
        addSubview(spinner)
        spinner.startAnimating()
    }

    public func stop() {
        spinner.stopAnimating()
        removeFromSuperview()
    }
}
