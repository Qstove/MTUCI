// Created by Anatoly Qstove on 07.03.2022.

import Foundation
import UIKit
import SnapKit

final class ButtonCell: UITableViewCell {
    private var button = ActionButton(style: .indigo)
    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        button.setTitle(title, for: .normal)
    }

    private func setupViews() {
        contentView.addSubview(button)
    }

    private func setupLayout() {
        button.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(cellOffset)
            $0.bottom.trailing.equalToSuperview().offset(-cellOffset)
        }
    }
}
