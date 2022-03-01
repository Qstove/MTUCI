// Created by Anatoly Qstove on 01.03.2022.

import Foundation

final class LoginInteractor: LoginInteractorInput {

    var presenter: LoginPresenterInput?

    func load() {
        let response = LoginModule.UseCase.Load.Response()
        presenter?.present(response)
    }
}
