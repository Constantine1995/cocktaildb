//
//  DrinksTableViewCell.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/16/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
