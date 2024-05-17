//
//  ViewController.swift
//  OpenWeatherAPITest
//
//  Created by 한유진 on 4/4/24.
//

import UIKit
import Alamofire
import Kingfisher
import CoreLocation

class ViewController: UIViewController {
    let apiKey = ProcessInfo.processInfo.environment["apiKey"] ?? ""
    let manager = CLLocationManager()
    var coordinate: (Double, Double) = (0, 0)
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
    }
    
    func search() {
        let endpoint = "https://api.openweathermap.org/data/2.5/weather"
        let params: Parameters = ["appid": apiKey, "lat": coordinate.0, "lon": coordinate.1, "units": "metric"]
        let alamo = AF.request(endpoint, method: .get, parameters: params)
        
        alamo.responseDecodable(of: Root.self) { response in
            switch response.result {
            case .success(let root):
                // MARK: - Get sunriseUTC
                let sunriseUTC = root.sys.sunrise
                let sunrise = Date(timeIntervalSince1970: Double(sunriseUTC))
                
                // MARK: - Set DateFormatter
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
                
                self.weatherLabel.text = root.weather[0].description
                self.dateLabel.text = formatter.string(from: sunrise)
                self.iconImageView.kf.setImage(with: URL(string: "https://openweathermap.org/img/wn/\(root.weather[0].icon)@2x.png"))
                
            case .failure(let error): 
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        search()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        coordinate = (location.coordinate.latitude, location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

