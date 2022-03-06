// Created by Anatoly Qstove on 07.03.2022.

import Foundation
import UIKit
import SnapKit

final class DisciplineCell: UITableViewCell {
    private let disciplineLabel = UILabel()
    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(discipline: String) {
        disciplineLabel.text = discipline
    }

    private func setupViews() {
        disciplineLabel.font = TextStyle.h2.font
        disciplineLabel.numberOfLines = 0
        disciplineLabel.textAlignment = .center
        contentView.addSubview(disciplineLabel)
    }

    private func setupLayout() {
        disciplineLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-cellOffset)
        }
    }
}
