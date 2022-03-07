// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import Combine

final class ScheduleView: UIViewController, ScheduleViewInput {

    let viewModel = ScheduleModule.ViewModel()
    var interactor: ScheduleInteractorInput?
    weak var router: ScheduleRouter?
    private var cancellables: Set<AnyCancellable> = []

    private let tableView = UITableView()
    private var spinnerView : SpinnerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.load()
    }

    private func setup() {
        setupSubviews()
        setupLayout()
        bind()
    }

    private func setupSubviews() {
        view.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.reuseIdentifier)
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
            spinnerView = SpinnerView()
            spinnerView?.start(on: view)
        } else {
            spinnerView?.stop()
            spinnerView = nil
        }
    }
}

extension ScheduleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseIdentifier) as? LessonCell else { return UITableViewCell() }
        guard let days = viewModel.days else { return UITableViewCell() }
        let lesson = days[indexPath.section].lessons[indexPath.row]
        cell.configure(
            discipline: lesson.discipline,
            teacherGroup: viewModel.role == .teacher ? lesson.group : lesson.teacher,
            lessonType: lesson.type,
            startTime: lesson.timeStart,
            endTime: lesson.timeEnd,
            auditory: lesson.auditory
        )
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let days = viewModel.days else { return UITableViewCell() }
        let day = days[section]
        let view = DayHeaderView()
        view.configure(date: day.date, dayName: day.name)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let days = viewModel.days else { return }
        let lesson = days[indexPath.section].lessons[indexPath.row]
        router?.route(output: .lessonDetail(model: lesson))
        tableView.deselectRow(at: indexPath, animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let days = viewModel.days else { return 0 }
        return days[section].lessons.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let days = viewModel.days else { return 0 }
        return days.count
    }
}
