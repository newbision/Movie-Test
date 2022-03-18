//
//  UtilsDate.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class UtilsDate: NSObject {

    public static func fromString(_ value: String?, Format format: String?, TimeZone timeZone: TimeZone?) -> Date? {
        if value == nil || value == "" {
            return nil
        }
        
        let df = DateFormatter()
        df.timeZone = (timeZone == nil) ? TimeZone.current : timeZone!
        df.dateFormat = (format == nil) ? DateTimeFormat.MMddyyyy_hhmma.rawValue : format!
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.date(from: value!)
    }
    
    static func toString(_ datetime: Date?, format: String?, timeZone: TimeZone?) -> String {
        guard let _ = datetime else {
            return ""
        }
        let df = DateFormatter()
        df.timeZone = (timeZone == nil) ? TimeZone.current : timeZone!
        df.dateFormat = (format == nil) ? DateTimeFormat.MMddyyyy_hhmma.rawValue : format!
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.string(from: datetime!)
    }
    
}

public enum DateTimeFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
    case MMddyyyy_hhmma = "MM-dd-yyyy hh:mm a"
    case MMddyyyy = "MM-dd-yyyy"
    case MMdd = "MM/dd"
    case MMddyy = "MM/dd/yy"
    case EEEEMMMMdyyyy = "EEEE, MMMM d, yyyy"
    case MMMdyyyy = "MMM d, yyyy"
    case MMMMdd = "MMMM dd"
    case hhmma = "hh:mm a"
    case hhmma_MMMd = "hh:mm a, MMM d"
}
