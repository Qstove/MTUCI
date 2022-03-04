// Created by Anatoly Qstove on 03.03.2022.

import Foundation
import UIKit
import SnapKit

final class DayCell: UITableViewCell {
    private let roundedContentView = UIView()
    private let dayLabel = UILabel()
    private let dayContentView = UIView()


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

    func configure(
        date: String,
        day: String,
        discipline: String,
        teacherGroup: String,
        lessonType: String,
        startTime: String,
        endTime: String,
        auditory: String
    ) {
        dayLabel.text = date + ", " + day
        infoLabel.text = "\(discipline)\n\(teacherGroup)\n\n\(lessonType)\nНачало: \(startTime)\nКонец: \(endTime)\nАудитория: \(auditory)"
    }

    private func setupViews() {
        contentView.backgroundColor = .clear
        roundedContentView.layer.borderColor = UIColor.gray.cgColor
        roundedContentView.layer.borderWidth = 1
        roundedContentView.layer.cornerRadius = 16
        contentView.addSubview(roundedContentView)

        dayContentView.layer.cornerRadius = 16
        dayContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dayContentView.backgroundColor = .rebeccaPurple
        roundedContentView.addSubview(dayContentView)

        dayLabel.font = TextStyle.h3.font
        dayLabel.textAlignment = .left
        dayLabel.textColor = .white

        dayContentView.addSubview(dayLabel)
        infoLabel.numberOfLines = 0
        roundedContentView.addSubview(infoLabel)
    }

    private func setupLayout() {
        roundedContentView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview()
        }
        dayContentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-4)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-cellOffset)
        }
    }
}
