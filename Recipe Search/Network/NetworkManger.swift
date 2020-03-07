//
//  NetworkManger.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManger{
    
    static var shared: NetworkManger = NetworkManger()
     
    func search(query: String, completionHandler : @escaping (Result<[String : Any]>)-> Void){
        let urlRequest: NetworkRoute = NetworkRoute.searchForRecipe(queryText: query)
        Alamofire.request(urlRequest).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                completionHandler(Result.success(value as! [String : Any]))
            case .failure(let error):
                 completionHandler(Result.failure(error))
            }
        }
    }
    
    private init(){
        
    }
}
