//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var posterImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    func setupUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        self.posterImageView.setWithImageUrl(viewModel.posterUrl, placeholder: nil, sessionToken: UtilsString.generateObjectId())
        self.titleLabel.text = viewModel.titleText
        self.releasedDateLabel.text = String.init(format: "Released on: %@", viewModel.longDateText)
        self.descriptionLabel.text = viewModel.overviewText
    }
    
}
