//
//  ViewController.swift
//  Sumation-iOS-Client
//
//  Created by Hanh Pham N on 12/02/2020.
//  Copyright (c) 2020 Hanh Pham N. All rights reserved.
//

import UIKit
import Summation_iOS_Client

class ViewController: UIViewController {
    
    @IBOutlet weak var queriesSttCodeLabel: UILabel!
    @IBOutlet weak var queriesDataLabel: UILabel!
    
    @IBOutlet weak var readSttCodeLabel: UILabel!
    @IBOutlet weak var readDataLabel: UILabel!
    
    @IBOutlet weak var getApiSttCodeLabel: UILabel!
    @IBOutlet weak var getApiDataLabel: UILabel!
    
    // Step1: Create client
    let summationClient = SummationClient.shared
    let gateway_token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdW1tYXRpb24iLCJzdWIiOiJhZG1pbiIsInVpZCI6MCwib3JnYW5pemF0aW9uX2lkIjowLCJhcHBsaWNhdGlvbl9pZCI6MCwicm9sZV9pZCI6MCwic2NvcGUiOiJkZXZlbG9wbWVudCIsImV4cCI6MjIzNzkwMjAyMy4zOTkyNDQzfQ.ROgO4hzjK0UCc1Ar_2-O0Q0ZsN5SHx-QEXAWkPC7QaoA8YEgWqTQeFGvZ6s8e94THGFFbJtQkvlfoJ9RWyDlgi4N8IIsHu3eM1eO1HxmhdZp3kSpMKSGvkRZ4jrGpFEHYLXQM8L1oMVghwfJHbRU7JywXlAvYArmpa3jw1_LVw3DUzojjJ6fv30OQJRz0dDACdxyqkvyVfA4ebNC2KWUjd_XMnIMvQxU4FJFAEVwW_Q2pJrucNb4GwswQuRvTUseXFYrP4XoFDag_iZe5chrNqJSAJFhvnSO9Px-HINqzein6zyE50-B30xiN8CwUGvAOt5v9qH11-Of4qEo51S8Uw"
    let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdW1tYXRpb24iLCJzdWIiOiJhZG1pbiIsInVpZCI6MCwib3JnYW5pemF0aW9uX2lkIjowLCJyb2xlX2lkIjowfQ.LWURX-7KPQqnAFLU4aF2W3di-MnhlyO3wVkhz7K2pzZi1XFUFXws7m0BnvBwQd70d39cWlmpOTCwG2RN8UD4bvaW9bfnv-qhEauYyNaXWbvSquTNKM5lrBxa4oIiNGmKfMYL3BNHqsl655z4p_3eMqkSZRXhgLroBeC7RPbSojBrr7zoAotLadBB0ImFYoffN4PdVK0AQFL9Kcz2C1FbliRd7HU9070REdRiuAKtAsg4Cl_vM0rHbUabgZoMaxKWbg5y-XBwSlKykYTqF58jqnHCoeNYdxPBlPiK4lBzXu3dtX2gqBq_4XMSWAGM6VKUw8G9l7DKl3klQV_JKKSz9w"
    let defaultDatabase = "summation"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STEP2: Configuration client
        let options = SummationOptions(gatewayUrl: "http://162.223.31.136:8000", token: token, gatewayToken: gateway_token, defaultDatabase: defaultDatabase)
        summationClient.setOptions(options)
    }

    @IBAction func didTapTestQueriesButton(_ sender: Any) {
        _ = summationClient.dbQueries(.query(sql: "SELECT * FROM queries WHERE id=:id", parameters: ["id": 1], databaseName: "summation")) { [weak self] (result) in
            switch result {
            case .success(let afDataResponse):
                switch afDataResponse.result {
                case .success(let data):
                    self?.queriesSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.queriesDataLabel.text = (data as? [[String: Any]])?.debugDescription
                case .failure(let error):
                    self?.queriesSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.queriesDataLabel.text = error.localizedDescription
                }
            case .failure(let error):
                self?.queriesSttCodeLabel.text = "Error"
                self?.queriesDataLabel.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func didTapReadQueriesButton(_ sender: Any) {
        _ = summationClient.dbQueries(.read(table: "Queries", parameters: ["id": 1], databaseName: "summation")) { [weak self] (result) in
            switch result {
            case .success(let afDataResponse):
                switch afDataResponse.result {
                case .success(let data):
                    self?.readSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.readDataLabel.text = (data as? [String: Any])?.debugDescription
                case .failure(let error):
                    self?.readSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.readDataLabel.text = error.localizedDescription
                }
            case .failure(let error):
                self?.readSttCodeLabel.text = "Error"
                self?.readDataLabel.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func didTapTestGetButton(_ sender: Any) {
        _ = summationClient.apiRequest(.get(url: "http://api.ipapi.com/98.33.28.214", parameters: nil, headers: nil )) { [weak self] (result) in
            switch result {
            case .success(let afDataResponse):
                switch afDataResponse.result {
                case .success(let data):
                    self?.getApiSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.getApiDataLabel.text = (data as? [String: Any])?.debugDescription
                case .failure(let error):
                    self?.getApiSttCodeLabel.text = "Success. Status code: \(String(describing: afDataResponse.response?.statusCode))"
                    self?.getApiDataLabel.text = error.localizedDescription
                }
            case .failure(let error):
                self?.getApiSttCodeLabel.text = "Error"
                self?.getApiDataLabel.text = error.localizedDescription
            }
        }
    }
}

