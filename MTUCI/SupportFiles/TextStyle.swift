// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit

public struct TextStyle: Equatable {

    public let font: UIFont
    public let paragraphSpacing: CGFloat?
    public let paragraphIndent: CGFloat?
    public let lineHeight: CGFloat?
    public let letterSpacing: CGFloat?

    public init(
        font: UIFont,
        paragraphSpacing: CGFloat? = nil,
        paragraphIndent: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        letterSpacing: CGFloat? = nil
    ) {
        self.font = font
        self.paragraphSpacing = paragraphSpacing
        self.paragraphIndent = paragraphIndent
        self.lineHeight = lineHeight
        self.letterSpacing = letterSpacing
    }

    public init(
        fontName: String,
        fontSize: CGFloat,
        paragraphSpacing: CGFloat? = nil,
        paragraphIndent: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        letterSpacing: CGFloat? = nil
    ) {
        self.init(
            font: UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
            paragraphSpacing: paragraphSpacing,
            paragraphIndent: paragraphIndent,
            lineHeight: lineHeight,
            letterSpacing: letterSpacing
        )
    }

    public func attributes(
        textColor: UIColor?,
        backgroundColor: UIColor? = nil,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        ignoringParagraphStyle: Bool = false
    ) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [.font: font]

        if let textColor = textColor {
            attributes[.foregroundColor] = textColor
        }

        if let backgroundColor = backgroundColor {
            attributes[.backgroundColor] = backgroundColor
        }

        if let letterSpacing = letterSpacing {
            attributes[.kern] = NSNumber(value: Float(letterSpacing))
        }

        if ignoringParagraphStyle {
            return attributes
        }

        let paragraphStyle = NSMutableParagraphStyle()

        if let lineHeight = lineHeight {
            let paragraphLineSpacing = (lineHeight - font.lineHeight) / 2.0
            let paragraphLineHeight = lineHeight - paragraphLineSpacing

            paragraphStyle.lineSpacing = paragraphLineSpacing
            paragraphStyle.minimumLineHeight = paragraphLineHeight
            paragraphStyle.maximumLineHeight = paragraphLineHeight
        }

        if let paragraphSpacing = paragraphSpacing {
            paragraphStyle.paragraphSpacing = paragraphSpacing
        }

        if let paragraphIndent = paragraphIndent {
            paragraphStyle.firstLineHeadIndent = paragraphIndent
        }

        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }

        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }

        attributes[.paragraphStyle] = paragraphStyle

        return attributes
    }
}

public extension TextStyle {
    // MARK: Заголовки
    static let h1 = TextStyle(font: .systemFont(ofSize: 28, weight: .bold), lineHeight: 36)
    static let h2 = TextStyle(font: .systemFont(ofSize: 24, weight: .bold), lineHeight: 28)
    static let h3 = TextStyle(font: .systemFont(ofSize: 20, weight: .bold), lineHeight: 24)

    // MARK: Основной текст
    static let t1Bold = TextStyle(font: .systemFont(ofSize: 16, weight: .bold), lineHeight: 20)
    static let t1Med = TextStyle(font: .systemFont(ofSize: 16, weight: .medium), lineHeight: 20)
    static let t1Reg = TextStyle(font: .systemFont(ofSize: 16, weight: .regular), lineHeight: 20)
    static let t2Med = TextStyle(font: .systemFont(ofSize: 14, weight: .medium), lineHeight: 18)
    static let t3Med = TextStyle(font: .systemFont(ofSize: 12, weight: .medium), lineHeight: 16)
    static let t3Reg = TextStyle(font: .systemFont(ofSize: 12, weight: .regular), lineHeight: 16)
}

public extension String {

    func styled(
        _ textStyle: TextStyle,
        textColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode? = nil
    ) -> NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: textStyle.attributes(
                textColor: textColor,
                backgroundColor: backgroundColor,
                alignment: alignment,
                lineBreakMode: lineBreakMode
            )
        )
    }
}
