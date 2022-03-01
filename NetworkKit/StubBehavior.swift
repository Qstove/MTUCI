// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import Moya

public enum StubBehavior {
    case never
    case delayed(seconds: TimeInterval)

    public func closure<Target>() -> MoyaProvider<Target>.StubClosure {
        switch self {
        case .never:
            return MoyaProvider.neverStub
        case .delayed(let seconds):
            return MoyaProvider.delayedStub(seconds)
        }
    }
}
