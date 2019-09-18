//
//  Category.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import ObjectMapper

//typealias Categories = ItemsLIst<Category>

class Category: NSObject, Mappable {
    
    // MARK: Properties
    
    var name: String?
    
    // MARK: Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["strCategory"]
    }
}
