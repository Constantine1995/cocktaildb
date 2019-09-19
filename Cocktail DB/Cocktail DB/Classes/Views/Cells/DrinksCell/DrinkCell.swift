//
//  DrinksTableViewCell.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/16/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit

class DrinkCell: UITableViewCell {
    
    // MARK: - Properties & IBOutlets
    
    @IBOutlet weak private var drinkImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    //MARK: - Setters
    
    func setDrinkImage(from urlString: String) {
        drinkImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder"))
    }
    
    func setNameLabelText(text: String) {
        nameLabel.text = text
    }
    
}
