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
    @IBOutlet weak var helathLabelCollectionView: UICollectionView!
    
    var recipe: Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        helathLabelCollectionView.dataSource = self
        helathLabelCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    func fillCellData(recipe: Recipe){
        titleLabel.text = recipe.title
        sourceLabel.text = recipe.source
        recipeImageView.load(url: recipe.imageURL)
        self.recipe = recipe

    }
}

extension RecipeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let cellRecipe = self.recipe{
            return cellRecipe.healthLables.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell_ID", for: indexPath) as! HealthLabelCollectionViewCell
        cell.healthLabel.text = recipe!.healthLables[indexPath.row]
        
        return cell
    }
    
    
}

