//
//  ImageDownloader.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
