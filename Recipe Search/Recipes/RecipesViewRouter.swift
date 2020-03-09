//
//  RecipesViewRouter.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit



protocol RecipesViewRouter {
    func presentDetailsView(for recipe: Recipe)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class RecipesViewRouterClass: RecipesViewRouter{
    
    private weak var recipesViewController: RecipesTableViewController?
    private var recipe: Recipe?
    
    init(viewController: RecipesTableViewController) {
        self.recipesViewController = viewController
    }
    
    func presentDetailsView(for recipe: Recipe) {
        self.recipe = recipe
        
        recipesViewController?.performSegue(withIdentifier: "detail_segue", sender: nil)
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationViewController = segue.destination as? DetailedViewController {
            guard let chosenRecipe = self.recipe else {
                return
            }
            destinationViewController.configurator = DetailedConfiguratorClass(recipe: chosenRecipe)
        }
    }
    
    
}
