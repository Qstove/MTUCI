// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class ScheduleInteractor: ScheduleInteractorInput {

    var presenter: SchedulePresenterInput?

    func load(_ request: ScheduleModule.UseCase.Load.Request) {
        presenter?.presentIsLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.presentIsLoading(false)
            let response = ScheduleModule.UseCase.Load.Response()
            self?.presenter?.present(response)
        }

    }
}
