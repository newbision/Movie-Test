//
//  MovieViewModel.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {

    var model: MovieDataModel? = nil
    
    var titleText: String {
        self.model?.title ?? ""
    }
    
    var ratingText: String {
        if let rating = self.model?.voteAverage {
            return String.init(format: "%.1f", rating)
        }
        return ""
    }
    
    var longDateText: String {
        if let date = UtilsDate.fromString(self.model?.releaseDateString, Format: DateTimeFormat.yyyyMMdd.rawValue, TimeZone: .UTC) {
            return UtilsDate.toString(date, format: DateTimeFormat.MMMdyyyy.rawValue, timeZone: .UTC)
        }
        return "N/A"
    }
    
    var shortDateText: String {
        if let date = UtilsDate.fromString(self.model?.releaseDateString, Format: DateTimeFormat.yyyyMMdd.rawValue, TimeZone: .UTC) {
            return UtilsDate.toString(date, format: DateTimeFormat.MMddyy.rawValue, timeZone: .UTC)
        }
        return "N/A"
    }
    
    var overviewText: String {
        self.model?.overview ?? ""
    }
    
    var posterUrl: URL? {
        URL(string: UrlManager.photoUrlString(filename: self.model?.posterPath ?? ""))
    }
    
    init(model: MovieDataModel) {
        self.model = model
    }
    
}
