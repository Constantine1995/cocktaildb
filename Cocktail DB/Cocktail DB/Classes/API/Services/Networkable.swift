//
//  Networkable.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    
    func fetchCategories(completion: @escaping (CategoriesList?, Error?) -> ())
    
    func fetchDrinks(categoryName: String, completion: @escaping (DrinkList?, Error?) -> ())
    
}
