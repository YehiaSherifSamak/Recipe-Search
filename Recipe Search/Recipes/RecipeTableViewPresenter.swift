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
    var isSearching: Bool {get}
    var numberOfCells: Int {get}
    func searchForRecipes(for query: String)
    func requestMoreRecipes()
    func configure(cell: RecipeViewCell, forRow row: Int)
    func configure(cell: SearchHistoryCell, forRow row: Int)
    func didSelect(row: Int)
    func whileSearching(text: String?)
    func cancelButtonClicked()
}

class RecipeTableViewPresenterClass {
    
    weak var view: RecipesTableView!
    var router: RecipesViewRouter
    private let databaseManger: DatabaseManger
    var isSearching = false
    
    private var recipes: [Recipe]
    private var searchHistory: [String]
    private var filteredSearchHistory: [String]
    private var from: Int
    private var to: Int
    private var count: Int
    private var more: Bool
    private var networkManger: NetworkManger
    private var lastQuery: String?
    private let piviot = 10
    
    
    init(view: RecipesTableViewController, networkManger: NetworkManger, router: RecipesViewRouter, databaseManger: DatabaseManger) {
        self.view = view
        self.networkManger = networkManger
        self.router = router
        self.databaseManger = databaseManger
        from = 0
        to = 10
        count = 0
        more = false
        recipes = [Recipe]()
        searchHistory = self.databaseManger.getSavedSearchHistory()
        filteredSearchHistory = [String]()
    }
    
    //MARK: -Rquesting Recipecs from API function
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
    
    func searchForRecipes(for query: String) {
        isSearching = false
        recipes = [Recipe]()
        from = 0
        lastQuery = query
        requestRecipes(query: query)
        addNewQueryToSearchHistory(query)
    }
    
    func requestMoreRecipes() {
        guard let query = lastQuery else{return}
        from += piviot
        if more{
            requestRecipes(query: query)
        }
    }
    //MARK: Parsing JSON
    func parsingJSON(_ json: JSON){
        from = json["from"].intValue
        to = json["to"].intValue
        count = json["count"].intValue
        more = json["more"].boolValue
        if(count == 0){
            view.thereIsNoRecipesErrorAlert()
        }
        for i in 0 ..< to - from {
            if i+from < count{
                let recipeJSON: JSON  = json["hits"][i]["recipe"]
                let recipe: Recipe = Recipe(json: recipeJSON)
                recipes.append(recipe)
            }
        }
    }
    
    
}
extension RecipeTableViewPresenterClass: RecipeTableViewPresenter{
    
    //MARK: -Tableview dataSource
    
    var numberOfCells: Int{
        return (isSearching) ? (view.isFiltering) ? filteredSearchHistory.count: searchHistory.count :  recipes.count
    }
    
    func configure(cell: RecipeViewCell, forRow row: Int){
        let recipeCellPresenter: RecipeCellPresenterClass = RecipeCellPresenterClass(recipe: recipes[row], cell: cell)
        recipeCellPresenter.configure()
    }
    
    func configure(cell: SearchHistoryCell, forRow row: Int) {
        let text = (view.isFiltering)  ? filteredSearchHistory[row] : searchHistory[row]
        cell.display(text: text)
    }
    
    func didSelect(row: Int){
        if(isSearching){
            let text = (view.isFiltering)  ? filteredSearchHistory[row] : searchHistory[row]
            searchForRecipes(for: text)
        }else{
            router.presentDetailsView(for: recipes[row])
        }
        
    }
    
    //MARK: Search bar functions
    
    func addNewQueryToSearchHistory(_ query: String){
        if !searchHistory.contains(query){
            searchHistory.insert(query, at: 0)
            removeLastElementInSearchHistory()
            databaseManger.savingSearchHistory(searchHistory)
        }
    }
    
    func removeLastElementInSearchHistory(){
        if(searchHistory.count > 10){
            searchHistory.removeLast()
        }
    }
    
    func whileSearching(text: String?){
        isSearching = true
        if let query = text{
            filterContentForSearchText(query)
        }
        view.updateTableView()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredSearchHistory = searchHistory.filter { (text: String) -> Bool in
            return text.lowercased().contains(searchText.lowercased())
        }
    }
    
    func cancelButtonClicked(){
        isSearching = false
        view.updateTableView()
    }
  
    
}

