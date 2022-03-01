// Created by Anatoly Qstove on 02.03.2022.

import Foundation

extension Bundle {
    private class Module { }

    static var module: Bundle {
        Bundle(for: Module.self)
    }
}
