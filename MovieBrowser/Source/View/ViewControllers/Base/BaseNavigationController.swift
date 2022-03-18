//
//  BaseNavigationController.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = .white
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
