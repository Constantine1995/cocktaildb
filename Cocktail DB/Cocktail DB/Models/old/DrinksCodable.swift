//
//  Drinks.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/16/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

typealias Codable = Encodable & Decodable
//typealias Drinks = List<DrinksCodable>// ItemsLIst<DrinksCodable>

struct DrinksCodable: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String

    enum CodingKeys: String, CodingKey {
        case strDrink
        case strDrinkThumb
        case idDrink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strDrink = try! container.decode(String.self, forKey: .strDrink)
        self.strDrinkThumb = try! container.decode(String.self, forKey: .strDrinkThumb)
        self.idDrink = try! container.decode(String.self, forKey: .idDrink)
    }
}
