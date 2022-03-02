// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class NewsInteractor: NewsInteractorInput {

    var presenter: NewsPresenterInput?

    func load(_ request: NewsModule.UseCase.Load.Request) {
        presenter?.presentIsLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.presentIsLoading(false)
            let response = NewsModule.UseCase.Load.Response()
            self?.presenter?.present(response)
        }

    }
}
