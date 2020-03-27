//
//  ImageCollectionViewCell.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageAuthor: UILabel!
    
    var imageData: ImageData? {
        didSet{
            imageAuthor.text = imageData?.author
            if let id = imageData?.id {
                self.image.load(forUrl: URLConstants.imageURl+"\(id)")
            }
        }
    }
}
