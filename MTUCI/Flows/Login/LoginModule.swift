// Created by Anatoly Qstove on 01.03.2022.

import Combine
import NetworkKit

protocol LoginInteractorInput: AnyObject {
    func load()
    func login(_ request: LoginModule.UseCase.Login.Request)
}

protocol LoginPresenterInput: AnyObject {
    func present(_ response: LoginModule.UseCase.Load.Response)
    func present(_ response: LoginModule.UseCase.Login.Response)
    func presentIsLoading(_ value: Bool)
}

protocol LoginViewInput: AnyObject {
    var viewModel: LoginModule.ViewModel { get }
    func displayMain(for person: AuthResponse.Person)
}

protocol LoginRouter: AnyObject {
    func route(output: LoginModule.Output)
}

enum LoginModule {

    enum UseCase {
        enum Load {
            struct Response { }
        }

        enum Login {
            struct Request {
                let username: String
                let password: String
            }
            struct Response {
                let person: AuthResponse.Person
            }
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
        case main(person: AuthResponse.Person)
    }
}
