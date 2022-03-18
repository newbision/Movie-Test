//
//  BaseViewController.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func showAlert(_ title: String,
                   Message message: String,
                   OkButtonTitle okButtonTitle: String,
                   OkCompletionBlock okCompletionBlock: (() -> ())?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let actionOk = UIAlertAction(title: okButtonTitle, style: .default) { (action:UIAlertAction) in
                okCompletionBlock?()
            }
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
