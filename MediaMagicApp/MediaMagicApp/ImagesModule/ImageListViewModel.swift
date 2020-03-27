//
//  ImageListViewModel.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation

class ImageListViewModel {
    
    private var networkManager: NetworkManagerType
    
    var errorMessageCallback: ((String) -> Void)?
    var moviesSuccessCallback: (() -> Void)?
    var loaderCallback: ((Bool) -> Void)?
    
    var images = [ImageData]()
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func fetchImages() {
        loaderCallback?(true)
        networkManager.fetchImagesData() { [weak self] (images, error) in
            self?.loaderCallback?(false)
            if let error = error {
                self?.errorMessageCallback?(error.localizedDescription)
                return
            } else {
                self?.images = images ?? []
                if let isEmpty = self?.images.isEmpty, isEmpty {
                    self?.errorMessageCallback?(NetworkError.dataNotFound.localizedDescription)
                }
                self?.moviesSuccessCallback?()
            }
        }
    }
}
