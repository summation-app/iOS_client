//
//  SummationIOSClient.swift
//  
//
//  Created by Hanh Pham N on 12/2/20.
//

import Foundation
import Alamofire

public class SummationClient {
    
    public static let shared = SummationClient()
    
    internal var options: SummationOptions = SummationOptions(gatewayUrl: "", token: "", gatewayToken: "", defaultDatabase: "")
    
    private init() {}
    
    public func setOptions(_ options: SummationOptions) {
        self.options = options
    }
    
    // MARK: Database query
    public func db(_ type: DatabaseQueriesType, completion: @escaping ApiCompletion) -> DataRequest? {
        guard configIsValidate() else {
            completion(.failure(SummationiOSClientError.notYetConfig))
            return nil
        }
        let target = SummationTarget.databaseQueries(type)
        return apiManager.request(target: target) { completion($0) }
    }
    
    public func api(_ type: APIRequestType, completion: @escaping ApiCompletion) -> DataRequest? {
        guard configIsValidate() else {
            completion(.failure(SummationiOSClientError.notYetConfig))
            return nil
        }
        let target = SummationTarget.api(type)
        return apiManager.request(target: target) { completion($0) }
    }
    
    public func chain(_ type: [SummationFuncType], completion: @escaping ApiCompletion) -> DataRequest? {
        guard configIsValidate() else {
            completion(.failure(SummationiOSClientError.notYetConfig))
            return nil
        }
        let target = SummationTarget.chain(type)
        return apiManager.request(target: target) { completion($0) }
    }
    
    private func configIsValidate() -> Bool {
        return !options.gatewayUrl.isEmpty &&
            !options.token.isEmpty &&
            !options.gatewayToken.isEmpty &&
            !options.defaultDatabase.isEmpty
    }
}
