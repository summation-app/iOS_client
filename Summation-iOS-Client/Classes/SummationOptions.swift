//
//  SummationConfig.swift
//  
//
//  Created by Hanh Pham N on 12/2/20.
//

import Foundation

public class SummationOptions {
    var gatewayUrl: String
    var token: String
    var gatewayToken: String
    var defaultDatabase: String
    
    init(gatewayUrl: String, token: String, gatewayToken: String, defaultDatabase: String) {
        self.gatewayUrl = gatewayUrl
        self.token = token
        self.gatewayToken = gatewayToken
        self.defaultDatabase = defaultDatabase
    }
}
