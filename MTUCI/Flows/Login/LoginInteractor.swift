// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import NetworkKit

final class LoginInteractor: LoginInteractorInput {

    var presenter: LoginPresenterInput?
    private let services: ApplicationServices
    private let stubBehavior: StubBehavior

    init(services: ApplicationServices, stubBehavior: NetworkKit.StubBehavior) {
        self.services = services
        self.stubBehavior = stubBehavior
    }

    func load() {
        let response = LoginModule.UseCase.Load.Response()
        presenter?.present(response)
    }

    func login(_ request: LoginModule.UseCase.Login.Request) {
        presenter?.presentIsLoading(true)
        let provider = services.api.provider(for: AuthService.self, stubBehavior: stubBehavior)
        provider.request(.login(username: request.username, password: request.password)) { [weak self] result in
            guard let self = self else { return }
//            let result: Result<CardBlockFormData, Error> = MoyaProcessor.DecodableResultProcessor(result)
            switch result {
            case .success(let response):
                break
            case .failure:
                break
            }
            self.presenter?.presentIsLoading(false)
        }
    }

}
