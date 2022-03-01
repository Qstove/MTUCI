// Created by Anatoly Qstove on 02.03.2022.

import UIKit
import SnapKit

public final class ActionButton: UIButton {
    public enum Style {
        case indigo
        case gray
    }

    public init(style: Style) {
        super.init(frame: .zero)
        setup()
        applyStyle(style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .white
        titleLabel?.font = TextStyle.t1Med.font
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    private func applyStyle(_ style: Style) {
        let color: UIColor

        switch style {
        case .indigo:
            color = .indigo
            setTitleColor(.white, for: .normal)
        case .gray:
            color = .gray
            setTitleColor(.black, for: .normal)
        }

        let normalImage = colorImage(color)
        setBackgroundImage(normalImage, for: .normal)
        let disabledImage = colorImage(color.withAlphaComponent(0.5))
        setBackgroundImage(disabledImage, for: .disabled)
    }

    private func colorImage(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
    }
}
