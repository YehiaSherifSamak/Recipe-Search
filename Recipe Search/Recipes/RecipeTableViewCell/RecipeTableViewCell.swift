//
//  RecipeTableViewCell.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

protocol RecipeViewCell: class {
    func display(title: String)
    func display(source: String)
    func display(imageURL: URL?)
    var presnter: RecipeCellPresenter? {get set}
}

class RecipeTableViewCell: UITableViewCell, RecipeViewCell{

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var helathLabelCollectionView: UICollectionView!
    
    var presnter: RecipeCellPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        helathLabelCollectionView.dataSource = self
        helathLabelCollectionView.delegate = self
    }
    
    func display(title: String) {
        titleLabel.text = title
      }
      
      func display(source: String) {
        sourceLabel.text = source
      }
      
      func display(imageURL: URL?) {
        recipeImageView.load(url: imageURL)
      }
}

extension RecipeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presnter?.numberOfHealthLables ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell_ID", for: indexPath) as! HealthLabelCollectionViewCell
        cell.healthLabel.text = presnter?.getHealthLabel(at: indexPath.row)
        return cell
    }
}

