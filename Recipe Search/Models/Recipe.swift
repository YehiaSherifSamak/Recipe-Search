//
//  Recipe.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Recipe {
    let title: String
    let source: String
    var healthLables: [String] = [String]()
    let imageURL: URL?
    var ingredients: [String] = [String]()
    let website: URL?
    
    func printRecipe(){
        print("Name: " + title + "\nSource: " + source)
    }
    
    init(json: JSON) {
        title = json["label"].stringValue
        imageURL = URL(string: json["image"].stringValue)
        source = json["source"].stringValue
        healthLables = json["healthLabels"].arrayValue.map{$0.stringValue}
        website = URL(string: json["url"].stringValue)
        ingredients = json["ingredientLines"].arrayValue.map{$0.stringValue}
        
    }
    
    func printIngredients()->String{
        let numberOfIngerdients = ingredients.count
        var recipeDetails: String = String()
        for i in 0 ..< numberOfIngerdients {
            recipeDetails += ingredients[i] + "\n\n"
        }
        return recipeDetails
    }
}
