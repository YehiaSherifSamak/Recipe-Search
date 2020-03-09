//
//  RecipesConfigurator.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation

protocol RecipesConfigurator {
    func configure(recipesTableViewController: RecipesTableViewController)
}

class RecipesConfiguratorClass: RecipesConfigurator{
    
    func configure(recipesTableViewController: RecipesTableViewController){
        let networkManger: NetworkManger = NetworkManger.shared
        let router: RecipesViewRouterClass = RecipesViewRouterClass(viewController: recipesTableViewController)
        let presenter: RecipeTableViewPresenterClass = RecipeTableViewPresenterClass(view: recipesTableViewController, networkManger: networkManger, router: router)
        
        recipesTableViewController.presenter = presenter
    }
}
