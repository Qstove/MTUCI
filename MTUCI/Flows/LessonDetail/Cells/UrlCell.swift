// Created by Anatoly Qstove on 07.03.2022.

import Foundation
import UIKit
import SnapKit

final class UrlCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let urlButton = UIButton()
    private var url: URL?

    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, placeholder: String, urlString: String?) {
        titleLabel.text = title
        if let urlString = urlString, let url = URL(string: urlString) {
            self.url = url
            urlButton.setTitle("Перейти", for: .normal)
            urlButton.setTitleColor(.blue, for: .normal)
            urlButton.addTarget(self, action: #selector(openUrl), for: .touchUpInside)
        } else {
            urlButton.setTitle(placeholder, for: .normal)
            urlButton.setTitleColor(.black, for: .normal)

        }
    }

    private func setupViews() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        contentView.addSubview(urlButton)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(cellOffset)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
        }
        urlButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-cellOffset)
        }
    }

    @objc private func openUrl() {
        guard let url = url else {
            return
        }
        UIApplication.shared.open(url)
    }
}
