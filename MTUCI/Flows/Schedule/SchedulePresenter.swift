// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class SchedulePresenter: SchedulePresenterInput {

    weak var view: ScheduleViewInput?

    func present(_ response: ScheduleModule.UseCase.Load.Response) {
        view?.viewModel.title = "Расписание"
        view?.viewModel.days = response.schedule.days
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }
}
