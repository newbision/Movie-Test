//
//  NetworkService.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    /// "callback" is optional, so it's already escaping
    func get(endpoint: String,
             params: [String: String]?,
             callback: ((NetworkResponseDataModel) -> ())?)
}

class NetworkService: NetworkServiceProtocol {
    
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    /// "callback" is optional, so it's already escaping
    func get(endpoint: String,
             params: [String: String]?,
             callback: ((NetworkResponseDataModel) -> ())?) {
        
        var urlString = endpoint
        var params: [String: String] = params ?? [:]
        params["api_key"] = NetworkService.apiKey
        
        urlString.append("?")
        for (key, value) in params {
            if key.count > 0 {
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                urlString.append(key + "=" + escapedValue + "&")
            }
        }
        
        if urlString.hasSuffix("&") {
            urlString = String(urlString.dropLast())
        }
        
        guard let url = URL(string: urlString) else {
            callback?(NetworkResponseDataModel.instanceForFailure())
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            callback?(NetworkResponseDataModel.instanceFromResponse(data: data, response: response, error: error))
        })
        task.resume()
    }
}
