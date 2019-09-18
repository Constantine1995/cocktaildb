//
//  DrinksListResponse.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/16/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

struct DrinksListResponse: Decodable {
    let drinks: DrinksCodable
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
