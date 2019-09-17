//
//  Networkable.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Foundation
import Moya
protocol Networkable {
    var categoryProvider: MoyaProvider<DrinksCategoryServices> { get }
    var drinkProvider: MoyaProvider<DrinksServices> { get }

    func getDrinksCategory(completion: @escaping ([DrinksCategory]?, Error?) -> ())
    func getDrinks(type: String, completion: @escaping ([Drinks]?, Error?) -> ())
}
