//
//  DrinkProvider.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

enum DrinkProvider : BaseProvider {
    
    case listCategories
    case listDrinks(categoryName: String)
    
}

extension DrinkProvider : TargetType {
    
    var path: String {
        switch self {
        case .listCategories:
            return "list.php"
        case .listDrinks:
            return "filter.php"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .listCategories:
            let parameters = ["c": "list"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .listDrinks(let categoryName):
            let parameters = ["c": categoryName]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
}
