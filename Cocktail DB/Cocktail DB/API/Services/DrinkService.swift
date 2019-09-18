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
    
    func fetchCategories(completion: @escaping (CategoriesList?, Error?) -> ()) {
        drinkProvider.request(.listCategories) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let categoriesList: CategoriesList = try decoder.decode(CategoriesList.self, from: value.data)
                    completion(categoriesList, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
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
            }
        }
    }
}
