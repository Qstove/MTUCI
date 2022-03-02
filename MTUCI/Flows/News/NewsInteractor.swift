// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class NewsInteractor: NewsInteractorInput {
    
    var presenter: NewsPresenterInput?
    
    func load(_ request: NewsModule.UseCase.Load.Request) {
        presenter?.presentIsLoading(true)
        presenter?.presentIsLoading(false)
        let response = NewsModule.UseCase.Load.Response()
        presenter?.present(response)
    }
}
