//
//  FilterCell.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/18/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//
import UIKit

class FilterCell: UITableViewCell  {
    
    // MARK: - Properties & IBOutlets
    
    @IBOutlet weak private var filterNameLabel: UILabel!
    
    //MARK: - Setters
    
    func setFilterNameLabelText(text: String) {
        filterNameLabel.text = text
    }
    
}
