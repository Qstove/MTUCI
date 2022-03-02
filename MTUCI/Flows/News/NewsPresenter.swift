// Created by Anatoly Qstove on 02.03.2022.

import Foundation

final class NewsPresenter: NewsPresenterInput {

    weak var view: NewsViewInput?

    func present(_ response: NewsModule.UseCase.Load.Response) {
        view?.viewModel.title = "Новости"
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }
}
