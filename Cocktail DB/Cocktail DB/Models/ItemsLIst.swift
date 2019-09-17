//
//  ItemsLIst.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import ObjectMapper

class ItemsLIst<T: Mappable>: NSObject, Mappable {
    
    // MARK: Properties
    
    var list: [T]?
    
    // MARK: Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        list <- map["drinks"]
    }
}

