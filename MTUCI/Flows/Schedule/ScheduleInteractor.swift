// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class ScheduleInteractor: ScheduleInteractorInput {

    var presenter: SchedulePresenterInput?

    func load(_ request: ScheduleModule.UseCase.Load.Request) {
        presenter?.presentIsLoading(true)
        presenter?.presentIsLoading(false)
        let response = ScheduleModule.UseCase.Load.Response()
        presenter?.present(response)
    }
}
