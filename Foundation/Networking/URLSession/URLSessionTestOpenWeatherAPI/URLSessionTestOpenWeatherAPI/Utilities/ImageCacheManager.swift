//
//  ImageCacheManager.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/18/24.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSURL, UIImage>()
    private init() {}
}
