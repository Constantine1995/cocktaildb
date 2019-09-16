//
//  DrinksCategoryListResponse.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

struct DrinksCategoryListResponse: Decodable {
    let drinks: [DrinksCategory]

    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
