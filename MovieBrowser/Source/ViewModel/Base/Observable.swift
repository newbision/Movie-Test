//
//  Observable.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

final class Observable<T> {
    
    typealias Observer = (T) -> Void
    var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(observer: Observer?, initialInvoke: Bool = true) {
        self.observer = observer
        if initialInvoke {
            observer?(value)
        }
    }
    
}
