//
//  MyViewController.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import UIKit

class MyViewController: UIViewController {
    var forecast: [String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let forecast,
              let weather = forecast["weather"] as? [[String: Any]]
        else { return }
        
        let description = weather[0]["description"] as? String
        let icon = weather[0]["icon"] as? String
        
        if let icon, let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
            ImageDownloader.shared.downloadImage(from: url) { image in
                self.iconImageView.image = image
            }
        }
        descriptionLabel.text = description
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
}
