//
//  DatabaseManger.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/10/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import Foundation

class DatabaseManger {
    
    //Importent Note:
    // I Prefer Using UserDefaults only beceause it is array of 10 strings
    // If the size was not constant I would prefer using realm database
    
    
    static var shared: DatabaseManger = DatabaseManger()
    private let defaults = UserDefaults.standard
    private init(){
        
    }
    
    func savingSearchHistory(_ suggestion: [String]){
       defaults.set(suggestion, forKey: "SavedSearchHistory")
    }
    
    func getSavedSearchHistory()->[String]{
        return defaults.stringArray(forKey: "SavedSearchHistory") ?? [String]()
    }
    
    
}
