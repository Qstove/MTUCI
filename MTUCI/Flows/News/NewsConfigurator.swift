// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import NetworkKit

final class NewsConfigurator {

    private let stubBehavior: StubBehavior

    init(isStubbed: Bool) {
        stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
    }

    func create(router: NewsRouter) -> UIViewController {
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let view = NewsView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
