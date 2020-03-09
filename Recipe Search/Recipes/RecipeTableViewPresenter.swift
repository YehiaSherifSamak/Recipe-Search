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
    var router: RecipesViewRouter {get}
    var numberOfRecipes: Int {get}
    func getRecipe(at i: Int)->Recipe
    
    func searchForRecipes(for query: String)
    func requestMoreRecipes()
    func configure(cell: RecipeViewCell, forRow row: Int)
    func didSelect(row: Int)
    
}

class RecipeTableViewPresenterClass {
    
    
   weak var view: RecipesTableView!
    var router: RecipesViewRouter
    private var recipes:[Recipe]
    private var from: Int
    private var to: Int
    private var count: Int
    private var more: Bool
    private var networkManger: NetworkManger
    private var lastQuery: String?
    private let piviot = 10
    
    var numberOfRecipes: Int{
        return recipes.count
    }
    
    init(view: RecipesTableViewController, networkManger: NetworkManger, router: RecipesViewRouter) {
        self.view = view
        self.networkManger = networkManger
        self.router = router
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
    
    
    func requestRecipes(query: String){
        networkManger.search(query: query, from: from) { [unowned self] (response) in
            switch response{
            case .success(let result):
                let json: JSON = JSON(result)
                self.parsingJSON(json)
                self.view.updateTableView()
            case .failure(let error):
                self.view.makeConnectionErrorAlert()
                print(error)
            }
        }
    }
    
    
    
}
extension RecipeTableViewPresenterClass: RecipeTableViewPresenter{
    
    func searchForRecipes(for query: String) {
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
    
    func configure(cell: RecipeViewCell, forRow row: Int){
        let recipeCellPresenter: RecipeCellPresenterClass = RecipeCellPresenterClass(recipe: recipes[row], cell: cell)
        recipeCellPresenter.configure()
    }
    func didSelect(row: Int){
        router.presentDetailsView(for: recipes[row])
    }
    
}

