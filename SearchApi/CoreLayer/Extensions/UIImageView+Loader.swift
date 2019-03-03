//
//  UIImageView+Loader.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, AnyObject>()

public extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        guard let url = URL(string: urlString) else { return }
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}
