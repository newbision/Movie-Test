//
//  CustomImageView.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    private var sessionToken: String? = nil
    
    func setWithImageUrl(_ url: URL?, placeholder: UIImage? = nil, sessionToken: String? = nil) {
        self.image = placeholder
        
        guard let url = url else {
            return
        }
        
        self.sessionToken = sessionToken
        URLSession.shared.dataTask(with: url) { [sessionToken, weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            if self?.sessionToken != sessionToken {
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

}
