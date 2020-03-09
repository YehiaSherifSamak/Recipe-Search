//
//  DetailedViewController.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/9/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit
import SafariServices

protocol DetailedView: class {
    func display(imageURL: URL?)
    func display(title: String)
    func display(ingredients: String)
}

class DetailedViewController: UIViewController, SFSafariViewControllerDelegate, DetailedView{
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    var presnter: DetailedPresenter!
    var configurator: DetailedConfigurator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        presnter.viewDidLoad()
        
    }
    
    func display(imageURL: URL?) {
        mainImageView.load(url: imageURL)
    }
    
    func display(title: String) {
        titleLabel.text = title
    }
    
    func display(ingredients: String) {
        ingredientsTextView.text = ingredients
    }
    
    @IBAction func checkTheWebsiteButtonClicked(_ sender: UIButton) {
        
        guard let url = presnter.websiteURL else {
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

