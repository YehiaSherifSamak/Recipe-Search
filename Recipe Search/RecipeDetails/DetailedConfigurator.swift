//
//  DetailedConfigurator.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation

protocol DetailedConfigurator {
    func configure(view: DetailedViewController)
}

class DetailedConfiguratorClass: DetailedConfigurator{
    let recipe: Recipe
    
    init(recipe: Recipe){
        self.recipe = recipe
    }
    
    func configure(view: DetailedViewController){
        let presenter: DetailedPresenterClass = DetailedPresenterClass(view: view, recipe: recipe)
        view.presnter = presenter
    }
}
