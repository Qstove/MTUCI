// Created by Anatoly Qstove on 03.03.2022.

import Foundation
import UIKit
import SnapKit

final class PhotoCell: UITableViewCell {
    private let photoView = UIImageView()
    private let cellOffset = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage?) {
        photoView.image = image
    }

    private func setupViews() {
        photoView.layer.cornerRadius = 25
        contentView.addSubview(photoView)
    }

    private func setupLayout() {
        photoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(cellOffset)
            $0.bottom.equalToSuperview().offset(-cellOffset)
            $0.center.equalToSuperview()
            $0.height.width.equalTo(76)
        }
    }
}
