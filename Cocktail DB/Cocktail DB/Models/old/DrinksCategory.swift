//
//  DrinksCategory.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

typealias Categories = DrinksList<DrinksCategory>

struct DrinksCategory: Codable, Equatable {
    var strCategory: String
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strCategory = try! container.decode(String.self, forKey: .strCategory)
    }
}

