//
//  UrlManager.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct UrlManager {
    
    static private let kBaseUrl = "https://api.themoviedb.org/3"
    static private let kImageBaseUrl = "https://image.tmdb.org/t/p/w500"

    public static func searchMovies() -> String {
        return String.init(format: "%@/search/movie", UrlManager.kBaseUrl)
    }
    
    public static func photoUrlString(filename: String) -> String {
        return String.init(format: "%@%@", UrlManager.kImageBaseUrl, filename)
    }
    
}
