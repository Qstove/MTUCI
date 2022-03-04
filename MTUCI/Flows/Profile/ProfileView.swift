// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import Combine

final class ProfileView: UIViewController, ProfileViewInput {

    let viewModel = ProfileModule.ViewModel()
    var interactor: ProfileInteractorInput?
    weak var router: ProfileRouter?
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
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.reuseIdentifier)
        tableView.register(FullNameCell.self, forCellReuseIdentifier: FullNameCell.reuseIdentifier)
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseIdentifier)
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
        viewModel.$cellTypes
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

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellTypes[indexPath.row]
        switch cellType {
        case .photoCell(let image, let placeholder):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.reuseIdentifier) as? PhotoCell else { return UITableViewCell() }
            let image = image == nil ? placeholder : image
            cell.configure(image: image)
            return cell
        case .fullNameCell(let firstName, let lastName, let middleName):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: FullNameCell.reuseIdentifier) as? FullNameCell
            else { return UITableViewCell() }
            cell.configure(firstName: firstName, lastName: lastName, middleName: middleName)
            return cell
        case .infoCell(let title, let subtitle):
            let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.reuseIdentifier)
            var content = cell.defaultContentConfiguration()
            content.text = title
            content.secondaryText = subtitle
            cell.contentConfiguration = content
            return cell
        case .headerCell(let text):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
            else { return UITableViewCell() }
            cell.configure(text: text)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes.count
    }
}
