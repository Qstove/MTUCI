// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class SchedulePresenter: SchedulePresenterInput {

    weak var view: ScheduleViewInput?

    func present(_ response: ScheduleModule.UseCase.Load.Response) {
        view?.viewModel.title = "Loaded"
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }
}
