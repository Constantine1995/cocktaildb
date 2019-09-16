//
//  NetworkManager.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

class NetworkManager: Networkable {
    
    var providerCategory = MoyaProvider<DrinksCategoryServices>(plugins: [NetworkLoggerPlugin(verbose: false)]) // used for testing
    var provider = MoyaProvider<DrinksServices>(plugins: [NetworkLoggerPlugin(verbose: false)]) // used for testing

//    static var environment: TypeDrinks = .ordinary_Drink
    static var environment: TypeDrinks?

    func getDrinksCategory(completion: @escaping ([DrinksCategory]?, Error?) -> ()) {
        
        providerCategory.request(.getDrinksCategory) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                     let drinksCategory: DrinksCategoryListResponse = try decoder.decode(DrinksCategoryListResponse.self, from: value.data)
                    completion(drinksCategory.drinks, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getDrinks(completion: @escaping ([Drinks]?, Error?) -> ()) {
        
        provider.request(.getDrinks) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let drinksList: DrinksListResponse = try decoder.decode(DrinksListResponse.self, from: value.data)
                    completion(drinksList.drinks, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getImage(completion: @escaping (UIImage?, Error?) -> ()) {
        
        provider.request(.getDrinks) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                return
//
//                let decoder = JSONDecoder()
//                do {
//                    let drinksList: DrinksListResponse = try decoder.decode(DrinksListResponse.self, from: value.data)
//                    completion(drinksList.drinks, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
            }
        }
    }
}
