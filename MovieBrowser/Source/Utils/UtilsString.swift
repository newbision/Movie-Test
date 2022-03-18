//
//  UtilsString.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class UtilsString: NSObject {

    public static func generateObjectId() -> String {
        let time = String(Int(Date().timeIntervalSince1970), radix: 16, uppercase: false)
        let machine = String(Int.random(in: 100000 ..< 999999))
        let pid = String(Int.random(in: 1000 ..< 9999))
        let counter = String(Int.random(in: 100000 ..< 999999))
        return time + machine + pid + counter
    }
    
}
