//
//  SearchMovieResponse.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct SearchMovieResponse {

    struct SuccessResponseDataModel: Codable {

        var page: Int
        var totalPages: Int
        var totalResults: Int
        var results: [MovieDataModel]
        
        enum CodingKeys: String, CodingKey {
            case page
            case totalPages = "total_pages"
            case totalResults = "total_results"
            case results
        }
        
    }
    
    struct FailureResponseDataModel: Codable {

        var statusCode: Int?
        var statusMessage: String?
        var success: Bool?
        var errors: [String]?
        
        enum CodingKeys: String, CodingKey {
            case success
            case statusCode = "status_code"
            case statusMessage = "status_message"
            case errors
        }
        
        func getErrorMessage() -> String? {
            if let message = self.errors?.first, message.isEmpty == false {
                return message
            }
            if let statusMessage = statusMessage, statusMessage.isEmpty == false {
                return statusMessage
            }
            return nil
        }
        
    }

}
