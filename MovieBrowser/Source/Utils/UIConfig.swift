//
//  UIConfig.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class UIConfig {

    enum StoryboardName: String {
        case main = "Main"
    }
    
    enum StoryboardID: String {
        case mainSearch = "Storyboard.Main.Search"
        case mainDetails = "Storyboard.Main.Details"
    }
    
    enum TableViewCellNibName: String {
        case movieItem = "MovieItemTableViewCell"
    }
    
    enum TableViewCellID: String {
        case movieItem = "TableViewCell.Search.MovieItem"
    }
    
}

enum ErrorMessage: String {
    
    case none = ""
    case unknown = "Sorry, we've encountered an unknown error."
    
    enum NetworkResponse: String {
        case unknown = "Sorry, we've encountered an unknown error while connecting server."
    }
    
    enum Search: String {
        case not_found = "No movie is found.\nPlease try other keyword."
        
    }
    
}
