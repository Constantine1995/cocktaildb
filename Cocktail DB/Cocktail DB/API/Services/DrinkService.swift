//
//  DrinkService.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

class DrinkService: Networkable {
    
    private var drinkProvider = MoyaProvider<DrinkProvider>()
    
    // get Category
    func fetchCategories(completion: @escaping (Categories?, Error?) -> ()) {
        
        drinkProvider.request(.listCategories) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let drinksList: Categories = try decoder.decode(Categories.self, from: value.data)
                    completion(drinksList, nil)
                } catch let error {
                    completion(nil, error)
                }
//                let json = try! JSONSerialization.jsonObject(with: value.data)
//                guard let dict = json as? [String: Any] else { return }
//                let categories = Categories(JSON: dict)
//                completion(categories, nil)
            }
        }
    }
    
    // get drinks
    //    func fetchDrinks(categoryName: String, completion: @escaping (Drinks?, Error?) -> ()) {
    //
    //        drinkProvider.request(.listDrinks(categoryName: categoryName)) { (response) in
    //            switch response.result {
    //            case .failure(let error):
    //                completion(nil, error)
    //            case .success(let value):
    ////                let decoder = JSONDecoder()
    ////                                do {
    ////                                    let drinksList: DrinksListResponse = try decoder.decode(DrinksListResponse.self, from: value.data)
    ////                                    completion(drinksList.drinks, nil)
    ////                                } catch let error {
    ////                                    completion(nil, error)
    ////                                }
    //                let json = try! JSONSerialization.jsonObject(with: value.data)
    //                guard let dict = json as? [String: Any] else { return }
    //                let drinks = Drinks(JSON: dict)
    //                completion(drinks, nil)
    //            }
    //        }
    //    }
    
    func fetchDrinks(categoryName: String, completion: @escaping (DrinkList?, Error?) -> ()) {
        
        drinkProvider.request(.listDrinks(categoryName: categoryName)) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let drinksList: DrinkList = try decoder.decode(DrinkList.self, from: value.data)
                    completion(drinksList, nil)
                } catch let error {
                    completion(nil, error)
                }
                //                let json = try! JSONSerialization.jsonObject(with: value.data)
                //                guard let dict = json as? [String: Any] else { return }
                //                let drinks = Drinks(JSON: dict)
                //                completion(drinks, nil)
            }
        }
    }
}
