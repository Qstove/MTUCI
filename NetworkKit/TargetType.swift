// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import Moya

extension TargetType {
    func sample(from resource: String, ofExtension: String) -> Data {
        guard let url = Bundle.module.url(forResource: resource, withExtension: ofExtension),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }

    public var baseURL: URL {
        URL(string: Endpoint.current.url)!
    }
}
