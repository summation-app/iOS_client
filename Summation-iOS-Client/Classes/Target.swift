//
//  Target.swift
//  BeSure
//
//  Created by Hanh Pham N on 1/8/20.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import Alamofire

public protocol Target {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}
