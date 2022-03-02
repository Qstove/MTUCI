// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class ProfilePresenter: ProfilePresenterInput {

    weak var view: ProfileViewInput?

    func present(_ response: ProfileModule.UseCase.Load.Response) {
        view?.viewModel.title = "Loaded"
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }
}
