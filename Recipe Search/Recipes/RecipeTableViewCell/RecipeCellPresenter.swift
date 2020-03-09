//
//  RecipeCellPresenter.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation

protocol RecipeCellPresenter {
    var numberOfHealthLables: Int {get}
    func getHealthLabel(at index: Int)->String
}

class RecipeCellPresenterClass: RecipeCellPresenter{
    
    private var recipe: Recipe
    weak var cell: RecipeViewCell!
    
    var numberOfHealthLables: Int{
        return recipe.healthLables.count
    }
    
    init(recipe: Recipe, cell: RecipeViewCell){
        self.recipe = recipe
        self.cell = cell
    }
    
    func configure(){
        cell.presnter = self
        cell.display(imageURL: recipe.imageURL)
        cell.display(title: recipe.title)
        cell.display(source: recipe.source)
    }
    
    func getHealthLabel(at index: Int)->String {
        return recipe.healthLables[index]
    }
}
