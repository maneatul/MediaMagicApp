//
//  UICollectionView+EmptyView.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.lightGray
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 1).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
    }
}
