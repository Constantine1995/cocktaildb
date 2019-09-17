//
//  DrinksServices.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya


enum DrinksCategoryServices: TargetType {
    case getDrinksCategory
        
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .getDrinksCategory:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getDrinksCategory:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
}
