// Created by Aleksandr Belbakov on 16.09.2021.

import Foundation
import Moya
import CoreKit

public enum MoyaProcessor {

    typealias ResultProcessor<ResultType> = (Result<Response, MoyaError>) -> ResultType

    public static func DecodableResultProcessor<DecodableType>(
        _ result: Result<Response, MoyaError>
    ) -> Result<DecodableType, Error> where DecodableType: Decodable {
        switch result {
        case .success(let moyaResponse):
            do {
                let _ = try moyaResponse.filterSuccessfulStatusCodes()
                let decoder = JSONDecoder()
                let response = try moyaResponse.map(DecodableType.self, using: decoder)
                return .success(response)
            } catch {
                if case let MoyaError.objectMapping(decodableError, _) = error {
                    print("Failed to decode '\(String(describing: DecodableType.self))' type")
                    print(decodableError)
                }
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
