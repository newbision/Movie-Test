//
//  MovieService.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

protocol MovieServiceProtocol: AnyObject {
    
    func requestGetNextPage(query: String, page: Int, callback: ((NetworkResponseDataModel) -> ())?)
    
}


class MovieService: MovieServiceProtocol {

    var networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - API Calls
    
    func requestGetNextPage(query: String, page: Int, callback: ((NetworkResponseDataModel) -> ())?) {
        let urlString = UrlManager.searchMovies()
        let params = [
            "query": query,
            "page": "\(page)"
        ]
        
        self.networkService.get(endpoint: urlString, params: params) { response in
            if let payload = response.payload {
                if response.isSuccess() {
                    do {
                        let result = try JSONDecoder().decode(SearchMovieResponse.SuccessResponseDataModel.self, from: payload)
                        response.parsedObject = result
                    }
                    catch {
                        print("Unexpected error: \(error).")
                    }
                }
                else {
                    do {
                        let result = try JSONDecoder().decode(SearchMovieResponse.FailureResponseDataModel.self, from: payload)
                        response.parsedObject = result
                    }
                    catch {
                        print("Unexpected error: \(error).")
                    }
                }
            }
            callback?(response)
        }
    }
    
}
