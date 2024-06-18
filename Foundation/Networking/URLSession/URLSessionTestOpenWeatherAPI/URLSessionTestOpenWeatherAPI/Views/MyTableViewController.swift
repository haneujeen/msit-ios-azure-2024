//
//  MyTableViewController.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import UIKit
import Kingfisher

class MyTableViewController: UITableViewController {
    var forecasts: [Forecast]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecasts"
        fetchForecasts()
    }
    
    func fetchForecasts() {
        guard let config = Bundle.main.object(forInfoDictionaryKey: "Config") as? [String: String],
              let APIKey = config["APIKey"] else { return }
        
        let endpoint = "https://api.openweathermap.org/data/2.5/forecast?lat=0&lon=0&appid=\(APIKey)"
        NetworkManager.shared.fetchData(from: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let root = try JSONDecoder().decode(Root.self, from: data)
                    self.forecasts = root.forecasts
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let forecast = forecasts?[indexPath.row] else { return cell }
        
        // Configure the cell...
        if let iconCode = forecast.weather.first?.iconCode,
           let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png") {
            let iconImageView = cell.viewWithTag(1) as? UIImageView
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
        
        let descriptionLabel = cell.viewWithTag(2) as? UILabel
        descriptionLabel?.text = forecast.weather.first?.description
        
        let captionLabel = cell.viewWithTag(3) as? UILabel
        let linuxTime = forecast.dateTime
        let timeInterval = TimeInterval(linuxTime)
        let swiftDate = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        captionLabel?.text = "\(formatter.string(from: swiftDate))"
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let controller = segue.destination as? MyViewController
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let forecast = forecasts?[indexPath.row]
            else { return }
            controller?.forecast = forecast
        }
    }
}
