//
//  SearchHistoryTableViewCell.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/10/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

protocol SearchHistoryCell {
    func display(text: String)
}

class SearchHistoryTableViewCell: UITableViewCell, SearchHistoryCell {
   
    
    @IBOutlet weak var searchHistoryLabel: UILabel!
    
    func display(text: String){
        searchHistoryLabel.text = text
    }
  
    


}
