//
//  AppService.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

protocol AppServiceProtocol: AnyObject {
    
    var networkService: NetworkServiceProtocol! { get set }
    var movieService: MovieServiceProtocol! { get set }
    
    func initializeAfterLaunch()
    
}

class AppService: AppServiceProtocol {

    public static let shared = AppService()
    
    var networkService: NetworkServiceProtocol!
    var movieService: MovieServiceProtocol!
    
    init() {
        self.networkService = NetworkService()
        self.movieService = MovieService(networkService: self.networkService)
    }
    
    func initializeAfterLaunch() {
        
    }
    
}
