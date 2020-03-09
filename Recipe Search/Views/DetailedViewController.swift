//
//  DetailedViewController.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit
import SafariServices

class DetailedViewController: UIViewController, SFSafariViewControllerDelegate{

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    func setUpUI(){
        guard let recipee = recipe else {
            return
        }
        mainImageView.load(url: recipee.imageURL)
        titleLabel.text = recipee.title
        ingredientsTextView.text = recipee.printIngredients()
    }
    
    @IBAction func checkTheWebsiteButtonClicked(_ sender: UIButton) {
        guard let recipee = recipe else {
                  return
              }
        guard let url = recipee.website else {
               return
           }

           let safariVC = SFSafariViewController(url: url)
           safariVC.delegate = self
           present(safariVC, animated: true, completion: nil)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

