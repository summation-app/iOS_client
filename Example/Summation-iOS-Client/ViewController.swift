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
    
    // Please get all config from https://docs.summation.app
    let gateway_token = ""
    let token = ""
    let defaultDatabase = ""
    let gatewayUrl = ""
    let apiUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STEP2: Configuration client
        let options = SummationOptions(gatewayUrl: gatewayUrl, token: token,
                                       gatewayToken: gateway_token, defaultDatabase: defaultDatabase)
        summationClient.setOptions(options)
    }

    @IBAction func didTapTestQueriesButton(_ sender: Any) {
        _ = summationClient.db(.query(sql: "SELECT * FROM queries WHERE id=:id", parameters: ["id": 1], databaseName: defaultDatabase)) { [weak self] (result) in
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
        _ = summationClient.db(.read(table: "Queries", parameters: ["id": 1], databaseName: defaultDatabase)) { [weak self] (result) in
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
        _ = summationClient.api(.get(url: apiUrl, parameters: nil, headers: nil)) { [weak self] (result) in
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

