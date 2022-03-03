// Created by Anatoly Qstove on 03.03.2022.

import UIKit

/// Protocol, that adds reuse identifier to any UITableViewCell & UICollectionViewCell
protocol UniqueCellIdentifier {
    static var reuseIdentifier: String { get }
}

extension UniqueCellIdentifier where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UniqueCellIdentifier where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UniqueCellIdentifier where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UniqueCellIdentifier where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: UniqueCellIdentifier {}
extension UITableViewHeaderFooterView: UniqueCellIdentifier {}
extension UICollectionReusableView: UniqueCellIdentifier {}
