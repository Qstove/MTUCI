// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import CoreKit

public final class AuthorizationService {

    private let keychain: Keychain

    init(keychain: Keychain) {
        self.keychain = keychain
    }

    public var hasPasscode: Bool {
        let status = try? keychain.contains(ApplicationKeychainGroup.passcodeKey.item)
        return status == true
    }

    public func clearPasscode() {
        try? keychain.remove(ApplicationKeychainGroup.passcodeKey.item)
    }
}
