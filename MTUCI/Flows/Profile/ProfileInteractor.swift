// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class ProfileInteractor: ProfileInteractorInput {
    
    var presenter: ProfilePresenterInput?
    
    func load(_ request: ProfileModule.UseCase.Load.Request) {
        presenter?.presentIsLoading(true)
        presenter?.presentIsLoading(false)
        let response = ProfileModule.UseCase.Load.Response()
        presenter?.present(response)
    }
}
