//
//  RecipeTableViewPresenter.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/7/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol RecipeTableViewPresenter {
    var view: RecipesTableViewController! {get set}
    func getRecipe(at i: Int)->Recipe
    func getNumberOfRecipes()->Int
    func searchForRecipes(query: String, completionHandler : @escaping (Bool)->Void)
}

class RecipeTableViewPresenterClass: RecipeTableViewPresenter{

    var view: RecipesTableViewController!
    var recipes:[Recipe]
    var from: Int
    var to: Int
    var count: Int
    var more: Bool
    var networkManger: NetworkManger
    
    init(view: RecipesTableViewController) {
        self.view = view
        networkManger = NetworkManger.shared
        from = 0
        to = 10
        count = 0
        more = false
        recipes = [Recipe]()
    }
    
    func searchForRecipes(query: String, completionHandler : @escaping (Bool)->Void){
        networkManger.search(query: query) { [weak self] (response) in
            switch response{
            case .success(let result):
                let json: JSON = JSON(result)
                self!.parsingJSON(json)
                completionHandler(true)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parsingJSON(_ json: JSON){
        from = json["from"].intValue
        to = json["to"].intValue
        count = json["count"].intValue
        more = json["more"].boolValue
        for i in from ..< to {
            let recipeJSON: JSON  = json["hits"][i]["recipe"]
            let name: String = recipeJSON["label"].stringValue
            let imageURLString: String = recipeJSON["image"].stringValue
            let source: String = recipeJSON["source"].stringValue
            let healthLables: [String] = recipeJSON["healthLabels"].arrayValue.map{$0.stringValue}
            let recipe: Recipe = Recipe(title: name, source: source, healthLables: healthLables, imageURL:
            URL(string: imageURLString))
            recipe.printRecipe()
            recipes.append(recipe)
        }
    }
    
    func getRecipe(at i: Int) -> Recipe {
        return recipes[i]
    }
    
    func getNumberOfRecipes() -> Int {
        return recipes.count
    }
}

