//
//  NetworkResponseDataModel.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class NetworkResponseDataModel: NSObject {

    var payload: Data? = nil
    var parsedObject: Any? = nil
    var code: Int! = NetworkResponseCode.ok.rawValue
    
    var errorMessage: String = ""
    
    func initialize() {
        self.payload = nil
        self.parsedObject = nil
        self.code = NetworkResponseCode.ok.rawValue
        self.errorMessage = ""
    }
    
    func isSuccess() -> Bool {
        return (200...299).contains(self.code)
    }
    
    func getBeautifiedErrorMessage() -> String {
        if self.isSuccess() {
            return ErrorMessage.none.rawValue
        }
        if self.errorMessage != "" {
            return self.errorMessage
        }
        return ErrorMessage.NetworkResponse.unknown.rawValue
    }
    
    static func instanceFromResponse(data: Data?, response: URLResponse?, error: Error?) -> NetworkResponseDataModel {
        let instance = NetworkResponseDataModel()
        
        guard let httpResponse = response as? HTTPURLResponse else {
            instance.code = NetworkResponseCode.badRequest.rawValue
            instance.errorMessage = ErrorMessage.NetworkResponse.unknown.rawValue
            return instance
        }
        
        instance.code = httpResponse.statusCode
        if let error = error {
            instance.errorMessage = error.localizedDescription
            return instance
        }

        if (200...299).contains(httpResponse.statusCode) == false && data == nil {
            instance.errorMessage = ErrorMessage.NetworkResponse.unknown.rawValue
        }
        
        instance.payload = data
        return instance
    }
    
    static func instanceForFailure(code: Int = NetworkResponseCode.badRequest.rawValue) -> NetworkResponseDataModel {
        let instance = NetworkResponseDataModel()
        instance.code = code
        return instance
    }
}

enum NetworkResponseCode: Int {
    case ok = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case preconditionFailed = 412
    case serverError = 500
}
