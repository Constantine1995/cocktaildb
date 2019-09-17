//
//  BaseProvider.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

protocol BaseProvider {}

extension BaseProvider {
    
    // MARK: - Properties
    
    var baseURL: URL {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/") else {
            fatalError("Base URL could not be configured.")
        }
        return url
    }
    var path: String {
        return ""
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestPlain
    }
    var sampleData: Data {
        return "Not used?".data(using: .utf8)!
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    var authorizationType: AuthorizationType {
        return .basic
    }
}
