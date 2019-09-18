//
//  DrinksList.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/18/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import ObjectMapper

class DrinksList<T: Codable>: NSObject, Codable {
    
    // MARK: Properties
    
    var drinks: [T]?
    
    // MARK: Initialization

    enum CodingKeys: String, CodingKey {
        case drinks
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try! container.decode([T].self, forKey: .drinks)
    }
}
