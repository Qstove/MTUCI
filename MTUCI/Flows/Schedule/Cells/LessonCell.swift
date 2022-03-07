// Created by Anatoly Qstove on 03.03.2022.

import Foundation
import UIKit
import SnapKit

final class LessonCell: UITableViewCell {
    private let infoLabel = UILabel()
    private let cellOffset = 16
    private let dayContentView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(
        discipline: String,
        teacherGroup: String,
        lessonType: String,
        startTime: String,
        endTime: String,
        auditory: String
    ) {
        infoLabel.text = "\(discipline)\n\(teacherGroup)\n\n\(lessonType)\nНачало: \(startTime)\nКонец: \(endTime)\nАудитория: \(auditory)"
    }

    private func setupViews() {
        dayContentView.backgroundColor = .white
        dayContentView.layer.cornerRadius = 16
        dayContentView.layer.shadowColor = UIColor.lightGray.cgColor
        dayContentView.layer.shadowOpacity = 0.25
        dayContentView.layer.shadowOffset = .zero
        dayContentView.layer.shadowRadius = 16

        contentView.addSubview(dayContentView)
        infoLabel.numberOfLines = 0
        dayContentView.addSubview(infoLabel)

    }

    private func setupLayout() {
        dayContentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.bottom.equalToSuperview().offset(-8)
        }
        infoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
