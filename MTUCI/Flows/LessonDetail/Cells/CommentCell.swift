// Created by Anatoly Qstove on 07.03.2022.

import Foundation
import UIKit
import SnapKit

final class CommentCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let backgroundCommentView = UIView()
    private let commentField = UITextView()

    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, text: String?, commentsIsEditable: Bool) {
        titleLabel.text = title
        commentField.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        commentField.font = TextStyle.t1Reg.font
        commentField.isEditable = commentsIsEditable
        commentField.text = text?.isEmpty == true ? "Преподаватель не оставил комментариев." : text
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        backgroundCommentView.backgroundColor = .white
        contentView.addSubview(backgroundCommentView)

        backgroundCommentView.layer.cornerRadius = 16
        backgroundCommentView.layer.shadowColor = UIColor.gray.cgColor
        backgroundCommentView.layer.shadowOpacity = 0.5
        backgroundCommentView.layer.shadowOffset = .zero
        backgroundCommentView.layer.shadowRadius = 16

        commentField.layer.cornerRadius = 16
        backgroundCommentView.addSubview(commentField)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(cellOffset)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
        }
        backgroundCommentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(cellOffset)
            $0.leading.equalToSuperview().offset(cellOffset)
            $0.trailing.equalToSuperview().offset(-cellOffset)
            $0.height.equalTo(200)
        }
        commentField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(commentField.snp.bottom).offset(cellOffset)
        }
    }
}
