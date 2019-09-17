//
//  NetworkManager.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya
//
//class NetworkManager: Networkable {
//    var categoryProvider: MoyaProvider<DrinksCategoryServices>
//
//    var drinkProvider: MoyaProvider<DrinksServices>
//
//
//    var providerCategory = MoyaProvider<DrinksCategoryServices>(plugins: [NetworkLoggerPlugin(verbose: false)])
//    var provider = MoyaProvider<DrinksServices>(plugins: [NetworkLoggerPlugin(verbose: false)])
//
//    // get Category
//    func getDrinksCategory(completion: @escaping ([DrinksCategory]?, Error?) -> ()) {
//
//        providerCategory.request(.getDrinksCategory) { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let value):
//                let decoder = JSONDecoder()
//                do {
//                     let drinksCategory: DrinksCategoryListResponse = try decoder.decode(DrinksCategoryListResponse.self, from: value.data)
//                    completion(drinksCategory.drinks, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
//
//    // get drinks
//    func getDrinks(type: String, completion: @escaping ([Drinks]?, Error?) -> ()) {
//
//        provider.request(.getDrinks(type: type)) { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let value):
//                let decoder = JSONDecoder()
//                do {
//                    let drinksList: DrinksListResponse = try decoder.decode(DrinksListResponse.self, from: value.data)
//                    completion(drinksList.drinks, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
//}
