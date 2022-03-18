//
//  MovieItemTableViewCell.swift
//  MovieBrowser
//
//  Created by newbision on 3/18/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(viewModel: MovieViewModel) {
        self.titleLabel.text = viewModel.titleText
        self.dateLabel.text = viewModel.longDateText
        self.scoreLabel.text = viewModel.ratingText
        
        self.selectionStyle = .none
    }
    
    static func getPreferredHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
