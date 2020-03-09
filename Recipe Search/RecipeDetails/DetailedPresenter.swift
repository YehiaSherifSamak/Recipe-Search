//
//  DetailedPresenter.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation
import SafariServices

protocol DetailedPresenter {
      func viewDidLoad()
    var websiteURL: URL? {get}
}
class DetailedPresenterClass: DetailedPresenter {
   
    var websiteURL: URL?{
        return recipe.website
    }
    
    weak var view: DetailedView!
    let recipe: Recipe
    
    init(view: DetailedView, recipe: Recipe) {
        self.recipe = recipe
        self.view = view
    }
    
    func viewDidLoad(){
        view.display(title: recipe.title)
        view.display(imageURL: recipe.imageURL)
        view.display(ingredients: recipe.printIngredients())
    }
    
}
