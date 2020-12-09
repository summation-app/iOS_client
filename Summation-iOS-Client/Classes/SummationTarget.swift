//
//  DatabaseQueries.swift
//  
//
//  Created by Hanh Pham N on 12/2/20.
//

import Foundation
import Alamofire

public protocol SummationFuncType {}

public enum DatabaseQueriesType: SummationFuncType {
    case query(sql: String, parameters: [String: Any], databaseName: String?)
    case create(table: String, parameters: [String: Any], databaseName: String?)
    case read(table: String, parameters: [String: Any], databaseName: String?)
    case update(table: String, parameters: [String: Any], databaseName: String?)
    case delete(table: String, parameters: [String: Any], databaseName: String?)
    case upsert(table: String, parameters: [String: Any], databaseName: String?)
}

public enum APIRequestType: SummationFuncType {
    case get(url: String, parameters: [String: Any]?, headers: [String: Any]?)
    case post(url: String, data: [String: Any]?, headers: [String: Any]?)
    case put(url: String, data: [String: Any]?, headers: [String: Any]?)
    case patch(url: String, data: [String: Any]?, headers: [String: Any]?)
    case delete(url: String, data: [String: Any]?, headers: [String: Any]?)
}

public enum SummationTarget: Target {
    case databaseQueries(_ type: DatabaseQueriesType)
    case api(_ type: APIRequestType)
    case chain(_ types: [SummationFuncType])
    
    public var path: String {
        switch self {
        case .api:
            return "api"
        case .databaseQueries:
            return "database"
        case .chain:
            return "chain"
        }
    }
    
    public var method: HTTPMethod {
        return .post
    }
    
    public var params: Parameters? {
        switch self {
        case .api(let type):
            switch type {
            case .get(let url, let parameters, let headers):
                return ["url": url,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "parameters": parameters ?? [:],
                        "headers": headers ?? [:],
                        "method": "GET"]
            case .post(let url, let data, let headers):
                return ["url": url,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "data": data ?? [:],
                        "headers": headers ?? [:],
                        "method": "POST"]
            case .put(let url, let data, let headers):
                return ["url": url,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "data": data ?? [:],
                        "headers": headers ?? [:],
                        "method": "PUT"]
            case .patch(let url, let data, let headers):
                return ["url": url,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "data": data ?? [:],
                        "headers": headers ?? [:],
                        "method": "PATCH"]
            case .delete(let url, let data, let headers):
                return ["url": url,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "data": data ?? [:],
                        "headers": headers ?? [:],
                        "method": "DELETE"]
            }
        case .databaseQueries(let type):
            switch type {
            case .query(let sql, let parameters, let databaseName):
                return ["sql": sql,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "parameters": parameters,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            case .create(let table, let parameters, let databaseName):
                return ["table": table,
                        "method": "create",
                        "parameters": parameters,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            case .read(let table, let parameters, let databaseName):
                return ["table": table,
                        "method": "read",
                        "parameters": parameters,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            case .update(let table, let parameters, let databaseName):
                return ["table": table,
                        "method": "update",
                        "parameters": parameters,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            case .upsert(let table, let parameters, let databaseName):
                return ["table": table,
                        "method": "upsert",
                        "parameters": parameters,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            case .delete(let table, let parameters, let databaseName):
                return ["table": table,
                        "method": "delete",
                        "parameters": parameters,
                        "token": SummationClient.shared.options.token,
                        "gateway_token": SummationClient.shared.options.gatewayToken,
                        "database_name": databaseName ?? SummationClient.shared.options.defaultDatabase]
            }
        case .chain(let types):
            var queue: [[String: Any?]] = []
            types.forEach { (type) in
                if let queryType = type as? DatabaseQueriesType {
                    switch queryType {
                    case .query(let sql, let parameters, let databaseName):
                        queue.append(["method": "query", "sql": sql,
                                      "parameters": parameters, "database_name": databaseName])
                    case .create(let table, let parameters, let databaseName):
                        queue.append(["method": "create", "table": table,
                                      "parameters": parameters, "database_name": databaseName])
                    case .read(let table, let parameters, let databaseName):
                        queue.append(["method": "read", "table": table,
                                      "parameters": parameters, "database_name": databaseName])
                    case .update(let table, let parameters, let databaseName):
                        queue.append(["method": "update", "table": table,
                                      "parameters": parameters, "database_name": databaseName])
                    case .upsert(let table, let parameters, let databaseName):
                        queue.append(["method": "upsert", "table": table,
                                      "parameters": parameters, "database_name": databaseName])
                    case .delete(let table, let parameters, let databaseName):
                        queue.append(["method": "upsert", "table": table,
                                      "parameters": parameters, "database_name": databaseName])
                    }
                } else if let apiType = type as? APIRequestType {
                    switch apiType {
                    case .get(let url, let parameters, let headers):
                        queue.append(["method": "GET", "url": url,
                                      "parameters": parameters, "headers": headers])
                    case .post(let url, let data, let headers):
                        queue.append(["method": "POST", "url": url,
                                      "data": data, "headers": headers])
                    case .put(let url, let data, let headers):
                        queue.append(["method": "PUT", "url": url,
                                      "data": data, "headers": headers])
                    case .patch(let url, let data, let headers):
                        queue.append(["method": "PATCH", "url": url,
                                      "data": data, "headers": headers])
                    case .delete(let url, let data, let headers):
                        queue.append(["method": "DELETE", "url": url,
                                      "data": data, "headers": headers])
                    }
                }
            }
            return ["token": SummationClient.shared.options.token,
                    "gateway_token": SummationClient.shared.options.gatewayToken,
                    "database_name": SummationClient.shared.options.defaultDatabase,
                    "queue": queue]
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
