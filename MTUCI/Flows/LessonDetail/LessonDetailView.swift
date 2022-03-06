// Created by Anatoly Qstove on 06.03.2022.

import UIKit
import SnapKit
import Combine

final class LessonDetailView: UIViewController, LessonDetailViewInput {

    let viewModel = LessonDetailModule.ViewModel()
    var interactor: LessonDetailInteractorInput?
    weak var router: LessonDetailRouter?
    private var cancellables: Set<AnyCancellable> = []

    private let tableView = UITableView()

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
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(DisciplineCell.self, forCellReuseIdentifier: DisciplineCell.reuseIdentifier)
        tableView.register(UrlCell.self, forCellReuseIdentifier: UrlCell.reuseIdentifier)
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
        viewModel.$cellTypes
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in self?.tableView.reloadData() })
            .store(in: &cancellables)
    }
}

extension LessonDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellTypes[indexPath.row]
        switch cellType {
        case .disciplineCell(let disciplineName):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: DisciplineCell.reuseIdentifier) as? DisciplineCell
            else { return UITableViewCell() }
            cell.configure(discipline: disciplineName)
            return cell
        case .infoCell(let title, let subtitle):
            let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.reuseIdentifier)
            var content = cell.defaultContentConfiguration()
            content.text = title
            content.secondaryText = subtitle
            cell.contentConfiguration = content
            return cell
        case .urlCell(let title, let placeholder, let urlString):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: UrlCell.reuseIdentifier) as? UrlCell
            else { return UITableViewCell() }
            cell.configure(title: title, placeholder: placeholder, urlString: urlString)
            return cell
        case .commentFieldCell(let title, let text, let commentsIsEditable):
            return UITableViewCell()
        case .buttonCell(model: let model):
            return UITableViewCell()
        }
            return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes.count
    }
}
