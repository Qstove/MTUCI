// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import Combine

final class ScheduleView: UIViewController, ScheduleViewInput {

    let viewModel = ScheduleModule.ViewModel()
    var interactor: ScheduleInteractorInput?
    weak var router: ScheduleRouter?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        interactor?.load(.init())
    }

    private func setup() {
        bind()
    }

    private func bind() {
        viewModel.$title
            .weakAssign(to: \.title, on: self)
            .store(in: &cancellables)
        viewModel.$isLoading
            .sink(receiveValue: { [weak self] in self?.displayIsLoading(value: $0) })
            .store(in: &cancellables)
    }

    private func displayIsLoading(value: Bool) {
        print(value)
    }
}
