// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import NetworkKit

final class ScheduleConfigurator {

    private let stubBehavior: StubBehavior

    init(isStubbed: Bool) {
        stubBehavior = isStubbed ? .delayed(seconds: 0.5) : .never
    }

    func create(router: ScheduleRouter) -> UIViewController {
        let interactor = ScheduleInteractor()
        let presenter = SchedulePresenter()
        let view = ScheduleView()
        view.router = router
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
