//
//  NetworkError.swift
//  BeSure
//
//  Created by Hanh Pham N on 1/8/20.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation

public struct SummationiOSClientError {
    static let noInternet = NSError(domain: "", code: -1_005,
                                    userInfo: [NSLocalizedDescriptionKey: "Please check internet connection"]) as Error
    static let notYetConfig = NSError(domain: "", code: -1_006,
                                      userInfo: [NSLocalizedDescriptionKey: "Please set Sumation Configurations"]) as Error
}
