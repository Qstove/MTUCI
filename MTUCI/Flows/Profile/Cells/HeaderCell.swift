// Created by Anatoly Qstove on 03.03.2022.

import Foundation
import UIKit
import SnapKit

final class HeaderCell: UITableViewCell {
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

    func configure(text: String) {
        nameLabel.text = text
    }

    private func setupViews() {
        nameLabel.font = TextStyle.h3.font
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
    }

    private func setupLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(cellOffset)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview()
        }
    }
}
