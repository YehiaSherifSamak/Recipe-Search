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
    var view: RecipesTableView! {get set}
    func getRecipe(at i: Int)->Recipe
    func getNumberOfRecipes()->Int
    func searchForRecipes(query: String)
    func requestMoreRecipes()
    
}

class RecipeTableViewPresenterClass: RecipeTableViewPresenter{
    

    var view: RecipesTableView!
    var recipes:[Recipe]
    var from: Int
    var to: Int
    var count: Int
    var more: Bool
    var networkManger: NetworkManger
    var lastQuery: String?
    let piviot = 10
    
    init(view: RecipesTableViewController) {
        self.view = view
        networkManger = NetworkManger.shared
        from = 0
        to = 10
        count = 0
        more = false
        recipes = [Recipe]()
    }
    
    func parsingJSON(_ json: JSON){
        from = json["from"].intValue
        to = json["to"].intValue
        count = json["count"].intValue
        more = json["more"].boolValue
        for i in 0 ..< to - from {
            let recipeJSON: JSON  = json["hits"][i]["recipe"]
            let recipe: Recipe = Recipe(json: recipeJSON)
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
    
    func requestRecipes(query: String){
        networkManger.search(query: query, from: from) { [unowned self] (response) in
            switch response{
            case .success(let result):
                let json: JSON = JSON(result)
                self.parsingJSON(json)
                self.view.updateTableView()
              // print(json)
            case .failure(let error):
                self.view.makeConnectionErrorAlert()
                print(error)
            }
        }
    }
    
    func searchForRecipes(query: String) {
        recipes = [Recipe]()
        from = 0
        lastQuery = query
        requestRecipes(query: query)
    }
      
      func requestMoreRecipes() {
        guard let query = lastQuery else{return}
        from += piviot
        if more{
            requestRecipes(query: query)
        }
      }
      
}

