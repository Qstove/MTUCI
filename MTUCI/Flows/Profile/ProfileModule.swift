// Created by Anatoly Qstove on 02.03.2022.

import Combine

protocol ProfileInteractorInput: AnyObject {
    func load(_ request: ProfileModule.UseCase.Load.Request)
}

protocol ProfilePresenterInput: AnyObject {
    func present(_ response: ProfileModule.UseCase.Load.Response)
    func presentIsLoading(_ value: Bool)
}

protocol ProfileViewInput: AnyObject {
    var viewModel: ProfileModule.ViewModel { get }
}

protocol ProfileRouter: AnyObject {
    func route(output: ProfileModule.Output)
}

enum ProfileModule {

    enum UseCase {
        enum Load {
            struct Request { }
            struct Response { }
        }
    }

    final class ViewModel: ObservableObject {
        @Published
        var title: String? = "Profile"
        @Published
        var isLoading: Bool = false
    }

    enum Output {

    }
}
