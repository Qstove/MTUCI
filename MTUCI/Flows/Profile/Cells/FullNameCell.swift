// Created by Anatoly Qstove on 03.03.2022.

import Foundation
import UIKit
import SnapKit

final class FullNameCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(firstName: String, lastName: String, middleName: String) {
        nameLabel.text = "\(firstName) \(lastName) \(middleName)"
    }

    private func setupViews() {
        nameLabel.font = TextStyle.h2.font
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }

    private func setupLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-cellOffset)
        }
    }
}
