//
//  NetworkManager.swift
//  MediaMagicApp
//
//  Created by Atul Mane on 25/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case dataNotFound
}

protocol NetworkManagerType {
    func fetchImagesData(completion: @escaping ([ImageData]?, Error?) -> ())
}

class NetworkManager: NetworkManagerType {
    
    let session = URLSession.shared
    
    func fetchImagesData(completion: @escaping ([ImageData]?, Error?) -> ()) {
        guard let url = URL(string: URLConstants.baseURl) else { return }
        session.dataTask(with: url, completionHandler: {data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NetworkError.dataNotFound)
                return
            }
            do {
                let imagesList = try JSONDecoder().decode([ImageData].self, from: data)
                completion(imagesList, nil)
            } catch let error {
                completion(nil, error)
            }
        }).resume()
    }
}
