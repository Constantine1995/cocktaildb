//
//  DrinksServices.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/15/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//


import Moya

enum TypeDrinks: String {
    case alcoholic
    case ordinary_Drink
    case сocktail
    case milkFloatShake
    case other
    case cocoa
    case shot
    case coffeeTea
    case homemadeLiquer
    case punchPartyDrink
    case beer
    case softDrinkSoda
}

enum DrinksServices: TargetType {
    case getDrinks
    var baseURL: URL {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(enviromentBaseURL)") else { fatalError("baseURL could not be configured")}
        return url
    }
    
    var path: String {
        return ""
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
        case .getDrinks:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
}

extension DrinksServices {
    
    var enviromentBaseURL: String {
        switch NetworkManager.environment {
        case .alcoholic?:
            return "Alcoholic"
        case .ordinary_Drink?:
            return "Ordinary_Drink"
        case .сocktail?:
            return "Cocktail"
        case .milkFloatShake?:
            return ""
        case .other?:
            return ""
        case .cocoa?:
            return "Cocoa"
        case .shot?:
            return "Shot"
        case .coffeeTea?:
            return ""
        case .homemadeLiquer?:
            return ""
        case .punchPartyDrink?:
            return ""
        case .beer?:
            return "Beer"
        case .softDrinkSoda?:
            return ""
            
        case .none:
            return ""
        }
        
    }
    
}
