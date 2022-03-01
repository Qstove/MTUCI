// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public protocol KeychainGroup {
    var item: KeychainQueryable { get }
    static var group: KeychainQueryable { get }
}
