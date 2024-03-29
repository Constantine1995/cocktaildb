//
//  Drinks.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/16/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

typealias Codable = Encodable & Decodable
typealias DrinkList = DrinksList<Drink>

struct Drink: Codable {
    
    // MARK: Properties
    
    var strDrink: String
    var strDrinkThumb: String
    
    // MARK: Initialization
    
    enum CodingKeys: String, CodingKey {
        case strDrink
        case strDrinkThumb
    }
    
}

extension Drink {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strDrink = try! container.decode(String.self, forKey: .strDrink)
        self.strDrinkThumb = try! container.decode(String.self, forKey: .strDrinkThumb)
    }
    
}
