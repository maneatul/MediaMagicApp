//
//  UIImageView+LoadFromAPI.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func load(forUrl url: String) {
        if let image = imageCache.object(forKey: url as NSString) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {(data, response, error) in
                if error != nil {
                    return
                }
                guard let image = UIImage(data: data!) else { return }
                imageCache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }).resume()
        }
    }
}
