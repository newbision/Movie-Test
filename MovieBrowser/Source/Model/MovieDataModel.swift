//
//  MovieDataModel.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDataModel: NSObject, Codable {

    var id: Int = 0
    var title: String? = nil
    var posterPath: String? = nil
    var releaseDateString: String? = nil
    var voteAverage: Float? = nil
    var overview: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDateString = "release_date"
        case voteAverage = "vote_average"
        case overview = "overview"
    }
    
}
