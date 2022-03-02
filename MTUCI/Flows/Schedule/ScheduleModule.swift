// Created by Anatoly Qstove on 02.03.2022.

import Combine

protocol ScheduleInteractorInput: AnyObject {
    func load(_ request: ScheduleModule.UseCase.Load.Request)
}

protocol SchedulePresenterInput: AnyObject {
    func present(_ response: ScheduleModule.UseCase.Load.Response)
    func presentIsLoading(_ value: Bool)
}

protocol ScheduleViewInput: AnyObject {
    var viewModel: ScheduleModule.ViewModel { get }
}

protocol ScheduleRouter: AnyObject {
    func route(output: ScheduleModule.Output)
}

enum ScheduleModule {

    enum UseCase {
        enum Load {
            struct Request { }
            struct Response { }
        }
    }

    final class ViewModel: ObservableObject {
        @Published
        var title: String? = "Schedule"
        @Published
        var isLoading: Bool = false
    }

    enum Output {

    }
}
