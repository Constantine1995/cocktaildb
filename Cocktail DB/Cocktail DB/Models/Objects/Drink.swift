//
//  Drink.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import ObjectMapper

typealias Drinks = ItemsLIst<Drink>

class Drink: Mappable {
    
    // MARK: Properties
    
    var id: Int?
    var name: String?
    var imageUrl: String?
    
    // MARK: Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idDrink"]
        name <- map["strDrink"]
        imageUrl <- map["strDrinkThumb"]
    }
}
