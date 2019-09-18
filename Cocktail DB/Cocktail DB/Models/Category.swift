//
//  Category.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

typealias CategoriesList = DrinksList<Category>

struct Category: Codable, Equatable {

    // MARK: Properties

    var strCategory: String
    
    // MARK: Initialization

    enum CodingKeys: String, CodingKey {
        case strCategory
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strCategory = try! container.decode(String.self, forKey: .strCategory)
    }
}

