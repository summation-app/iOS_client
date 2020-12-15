//
//  ApiDefine.swift
//  BeSure
//
//  Created by Hanh Pham N on 1/13/20.
//  Copyright © 2020 besurenetworking. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkReachabilityManager {
    static var shared: NetworkReachabilityManager {
        guard let manager = NetworkReachabilityManager() else {
            fatalError("Can't init network manager")
        }
        return manager
    }
}

public typealias ApiCompletion = (Result<AFDataResponse<Any>, Error>) -> Void

let apiManager = APIManager()

class APIManager {
    
    var networkAvailable: Bool {
        switch NetworkReachabilityManager.shared.status {
        case .unknown, .notReachable: return false
        case .reachable: return true
        }
    }
    
    func request(target: Target, completion: @escaping ApiCompletion) -> DataRequest? {
        guard networkAvailable else {
            completion(.failure(SummationiOSClientError.noInternet))
            return nil
        }
        let request = AF.request(SummationClient.shared.options.gatewayUrl / target.path,
                                 method: target.method,
                                 parameters: target.params,
                                 encoding: target.encoding,
                                 headers: target.headers)
        
        request.responseJSON { (response) in
            completion(.success(response))
        }
        return request
    }
}
