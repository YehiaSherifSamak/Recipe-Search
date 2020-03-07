//
//  Recipe.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation

struct Recipe {
    let title: String
    let source: String
    var healthLables: [String] = [String]()
    let imageURL: URL?
    
    
    func printRecipe(){
        print("Name: " + title + "\nSource: " + source)
    }
}
