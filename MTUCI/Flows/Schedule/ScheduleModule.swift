// Created by Anatoly Qstove on 02.03.2022.

import Combine
import NetworkKit

protocol ScheduleInteractorInput: AnyObject {
    func load()
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
            struct Response {
                let schedule: ScheduleResponse
            }
        }
    }

    final class ViewModel: ObservableObject {

        @Published
        var title: String? = "Расписание"
        @Published
        var isLoading: Bool = false
        @Published
        var days: [ScheduleResponse.Day]?
    }

    enum Output {
        case lessonDetail(model: ScheduleResponse.Lesson)
    }
}
