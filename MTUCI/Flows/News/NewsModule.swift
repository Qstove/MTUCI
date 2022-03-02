// Created by Anatoly Qstove on 02.03.2022.

import Combine

protocol NewsInteractorInput: AnyObject {
    func load(_ request: NewsModule.UseCase.Load.Request)
}

protocol NewsPresenterInput: AnyObject {
    func present(_ response: NewsModule.UseCase.Load.Response)
    func presentIsLoading(_ value: Bool)
}

protocol NewsViewInput: AnyObject {
    var viewModel: NewsModule.ViewModel { get }
}

protocol NewsRouter: AnyObject {
    func route(output: NewsModule.Output)
}

enum NewsModule {

    enum UseCase {
        enum Load {
            struct Request { }
            struct Response { }
        }
    }

    final class ViewModel: ObservableObject {
        @Published
        var title: String? = "News"
        @Published
        var isLoading: Bool = false
    }

    enum Output {

    }
}
