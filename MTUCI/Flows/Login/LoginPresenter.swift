// Created by Anatoly Qstove on 01.03.2022.

import Foundation

final class LoginPresenter: LoginPresenterInput {

    weak var view: LoginViewInput?

    func present(_ response: LoginModule.UseCase.Load.Response) {
        view?.viewModel.title = "Авторизация"
        view?.viewModel.labelText = "Мой университет 1.0"
        view?.viewModel.loginButton = .init(title: "Войти", isEnabled: true)
    }

    func present(_ response: LoginModule.UseCase.Login.Response) {
        view?.displayMain(for: response.person)
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }
}
