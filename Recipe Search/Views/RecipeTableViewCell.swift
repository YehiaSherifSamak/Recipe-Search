//
//  RecipeTableViewCell.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var healthLablesStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    func fillCellData(recipe: Recipe){
        titleLabel.text = recipe.title
        sourceLabel.text = recipe.source
        recipeImageView.load(url: recipe.imageURL)
        genrateHealthLabels(healthLabels: recipe.healthLables)
    }
    
    func genrateHealthLabels(healthLabels: [String]){
        let numberOfLables = healthLabels.count
        for i in 0 ..< numberOfLables{
            let label = UILabel()
            label.text = healthLabels[i]
            label.textColor = .gray
            label.font = .systemFont(ofSize: 10)
            healthLablesStackView.addArrangedSubview(label)
        }
    }

}
