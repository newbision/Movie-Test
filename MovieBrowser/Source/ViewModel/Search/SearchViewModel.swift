//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewModel: NSObject {

    var movieService: MovieServiceProtocol!
    var movies: [MovieViewModel] = []
    
    var keyword: String = ""
    var page: Int = 0
    let pageSize: Int = 20
    var totalPages: Int = 0
    var totalResults: Int = 0
    
    // MARK: - Computed Properties
    
    var resultsCount: Int {
        self.movies.count
    }
    
    // MARK: - Initializers
    
    init(movieService: MovieServiceProtocol) {
        super.init()
        self.movieService = movieService
    }
    
    // MARK: - Utility Funcs
    
    func clearSearch() {
        self.keyword = ""
        self.page = 1
        self.totalPages = 0
        self.totalResults = 0
        self.movies = []
    }
    
    func canLoadMore() -> Bool {
        return self.page < self.totalPages
    }
    
    // MARK: - Requests

    func requestGetMovies(newKeyword: String?, callback: ((Bool, String) -> ())?) {
        guard let movieService = self.movieService else {
            callback?(false, ErrorMessage.unknown.rawValue)
            return
        }
        
        if let newKeyword = newKeyword {
            /// new search
            self.clearSearch()
            self.keyword = newKeyword
        }
        else {
            /// append
            self.page = self.page + 1
        }
        
        movieService.requestGetNextPage(query: self.keyword, page: self.page) { [weak self] response in
            if response.isSuccess(), let result = response.parsedObject as? SearchMovieResponse.SuccessResponseDataModel {
                self?.page = result.page
                self?.totalPages = result.totalPages
                self?.totalResults = result.totalResults
                
                for item in result.results {
                    self?.movies.append(MovieViewModel(model: item))
                }
                
                if result.results.count == 0 && self?.page == 1 {
                    callback?(false, ErrorMessage.Search.not_found.rawValue)
                }
                else {
                    callback?(true, ErrorMessage.none.rawValue)
                }
            }
            else if !response.isSuccess(), let result = response.parsedObject as? SearchMovieResponse.FailureResponseDataModel {
                callback?(false, result.getErrorMessage() ?? response.getBeautifiedErrorMessage())
            }
            else {
                callback?(false, response.getBeautifiedErrorMessage())
            }
        }
    }
    
}
