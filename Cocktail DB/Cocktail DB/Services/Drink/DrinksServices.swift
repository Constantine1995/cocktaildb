//
//  DrinksServices.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//


import Moya

enum DrinksServices: TargetType {
    
    case getDrinks(type: String)
    
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getDrinks(_):
            return "/filter.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDrinks:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getDrinks(let type):
            return .requestParameters(parameters: [
                "c": type
                ], encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
}

