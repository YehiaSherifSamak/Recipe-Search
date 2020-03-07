//
//  UIImageViewExtention.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/7/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL?) {
        DispatchQueue.global().async { [weak self] in
            if let imageURL = url{
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
            
        }
    }
}
