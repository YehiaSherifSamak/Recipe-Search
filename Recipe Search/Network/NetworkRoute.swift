//
//  NetworkRoute.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkRoute: URLRequestConvertible{
   
    case searchForRecipe(queryText: String, from: Int = 0)
    
    func asURLRequest() throws -> URLRequest {
        var url: URL {
            switch self {
            case .searchForRecipe:
                return URL(string: "https://api.edamam.com/search")!
          
            }
        }
        var method: HTTPMethod = .get
        
        let appID: String = "24784c5e"
        let appKey: String = "8be3cea3bae5cb03c735d869093d05af"
        var parameters: [String : String]{
            switch self {
            case .searchForRecipe(let query, let from):
                return ["q": query, "app_id" : appID, "app_key" : appKey, "from" : String(from)]
            }
        }
        let urlRequest : URLRequest = try! URLRequest(url: url, method: method)
        let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        return encodedURLRequest
    }
    
    
}
