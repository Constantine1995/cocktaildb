//
//  DrinkCategoryHeader.swift
//  testTaskCocktails
//
//  Created by Artur Tarasenko on 4/24/19.
//  Copyright © 2019 Artur Tarasenko. All rights reserved.
//

import UIKit

class DrinkCategoryHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties & IBOutlets
    
    @IBOutlet weak private var categoryLabel: UILabel!
    
    //MARK: - Setters
    
    func setcategoryLabelText(text: String) {
        categoryLabel.text = text
    }
    
}
