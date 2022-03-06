// Created by Anatoly Qstove on 06.03.2022.

import Foundation
import UIKit

final class DayHeaderView: UITableViewCell {
    private let infoLabel = UILabel()
    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(date: String, dayName: String) {
        backgroundColor = .royalBlue
        infoLabel.text = "\(date), \(dayName)"
    }

    private func setupViews() {
        infoLabel.font = TextStyle.h3.font
        infoLabel.textColor = .white
        contentView.addSubview(infoLabel)
    }

    private func setupLayout() {
        infoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
