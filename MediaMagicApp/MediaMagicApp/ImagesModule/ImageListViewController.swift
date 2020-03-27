//
//  ImageListViewController.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    var viewModel: ImageListViewModel!
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = ImageListViewModel(networkManager: NetworkManager())
        }
        title = "Lorem Picsum"
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        setupObservers()
    }
    
    func setupObservers() {
        
        viewModel.errorMessageCallback = { errorMessage in
            DispatchQueue.main.async { [weak self] in
                if errorMessage.isEmpty {
                    self?.imageCollection.backgroundView = nil
                } else {
                    self?.imageCollection.setEmptyView(message: errorMessage)
                }
            }
        }
        
        viewModel.loaderCallback = { shouldShow in
            DispatchQueue.main.async { [weak self] in
                shouldShow ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.moviesSuccessCallback = {
            DispatchQueue.main.async { [weak self] in
                self?.imageCollection.reloadData()
            }
        }
        viewModel.fetchImages()
    }
}

extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageData = viewModel.images[indexPath.row]
        return cell
    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2.0
        let height = width + CGFloat(integerLiteral: 10)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
