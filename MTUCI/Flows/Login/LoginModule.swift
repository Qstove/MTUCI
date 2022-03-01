// Created by Anatoly Qstove on 01.03.2022.

import Combine

protocol LoginInteractorInput: AnyObject {
    func load()
}

protocol LoginPresenterInput: AnyObject {
    func present(_ response: LoginModule.UseCase.Load.Response)
    func presentIsLoading(_ value: Bool)
}

protocol LoginViewInput: AnyObject {
    var viewModel: LoginModule.ViewModel { get }
}

protocol LoginRouter: AnyObject {
    func route(output: LoginModule.Output)
}

enum LoginModule {

    enum UseCase {
        enum Load {
            struct Response { }
        }
    }

    final class ViewModel: ObservableObject {

        struct ActionButton {
            var title: String
            var isEnabled: Bool
        }

        @Published
        var title: String?
        @Published
        var isLoading: Bool = false
        @Published
        var labelText: String?
        @Published
        var loginButton: ActionButton?
    }

    enum Output {

    }
}
