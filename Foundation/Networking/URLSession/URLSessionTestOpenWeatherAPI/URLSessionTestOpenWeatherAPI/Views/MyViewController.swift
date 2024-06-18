//
//  MyViewController.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import UIKit
import Kingfisher

class MyViewController: UIViewController {
    var forecast: Forecast?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let forecast else { return }
        
        if let iconCode = forecast.weather.first?.iconCode,
           let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png") {
            if let cachedImage = ImageCacheManager.shared.object(forKey: url as NSURL) {
                iconImageView?.image = cachedImage
            } else {
                iconImageView?.kf.setImage(with: url, completionHandler: { result in
                    switch result {
                    case .success(let value):
                        ImageCacheManager.shared.setObject(value.image, forKey: url as NSURL)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        }
        descriptionLabel.text = forecast.weather.first?.description
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
}
