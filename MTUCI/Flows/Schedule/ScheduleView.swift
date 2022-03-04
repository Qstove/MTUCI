// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import Combine

final class ScheduleView: UIViewController, ScheduleViewInput {

    let viewModel = ScheduleModule.ViewModel()
    var interactor: ScheduleInteractorInput?
    weak var router: ScheduleRouter?
    private var cancellables: Set<AnyCancellable> = []

    private let tableView = UITableView()
    private var loadingVC: LoadingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        interactor?.load()
    }

    private func setup() {
        setupSubviews()
        setupLayout()
        bind()
    }

    private func setupSubviews() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.reuseIdentifier)
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {
        viewModel.$title
            .weakAssign(to: \.title, on: self)
            .store(in: &cancellables)
        viewModel.$isLoading
            .sink(receiveValue: { [weak self] in self?.displayIsLoading($0) })
            .store(in: &cancellables)
        viewModel.$days
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in self?.tableView.reloadData() })
            .store(in: &cancellables)
    }

    private func displayIsLoading(_ isLoading: Bool) {
        if isLoading {
            let lvc = LoadingViewController()
            lvc.modalPresentationStyle = .overCurrentContext
            lvc.modalTransitionStyle = .crossDissolve
            present(lvc, animated: true, completion: nil)
            loadingVC = lvc
        } else {
            loadingVC?.dismiss(animated: true, completion: { self.loadingVC = nil  })
        }
    }
}

extension ScheduleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.reuseIdentifier) as? DayCell else { return UITableViewCell() }
        guard let days = viewModel.days else { return UITableViewCell() }
        let day = days[indexPath.row]
        cell.configure(
            date: day.date,
            day: day.name,
            discipline: day.lesson.discipline,
            teacherGroup: day.lesson.teacher,
            lessonType: day.lesson.type,
            startTime: day.lesson.timeStart,
            endTime: day.lesson.timeEnd,
            auditory: day.lesson.auditory
        )
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.days?.count ?? 0
    }
}
