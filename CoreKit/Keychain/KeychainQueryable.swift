// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public protocol KeychainQueryable {
    var attributes: [String: Any] { get }
    var lookupAttributes: [String: Any] { get }
    var updateAttributes: [String: Any] { get }
}
