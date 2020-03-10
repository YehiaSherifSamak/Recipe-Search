//
//  ViewControllerExtention.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/10/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit
 
private var aView: UIView?

extension UIViewController{
   
    func showSpinner(){
        
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
        
    }
    
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}
