// Created by Anatoly Qstove on 01.03.2022.

import Foundation

public enum KeychainError: Error {
    case itemNotFound
    case invalidItemFormat
    case securityError(status: OSStatus)
}
