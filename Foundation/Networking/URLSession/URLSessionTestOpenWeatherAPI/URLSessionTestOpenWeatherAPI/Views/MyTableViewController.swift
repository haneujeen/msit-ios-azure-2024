//
//  MyTableViewController.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import UIKit

class MyTableViewController: UITableViewController {
    var forecasts: [[String:Any]]?
    
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
                if let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    self.forecasts = dict["list"] as? [[String: Any]]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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
        guard let forecast = forecasts?[indexPath.row],
              let weather = forecast["weather"] as? [[String: Any]],
              let temperatureItem = forecast["main"] as? [String: Any]
        else { return cell }
        
        // Configure the cell...
        let description = weather[0]["description"] as? String
        let icon = weather[0]["icon"] as? String
        let temperature = temperatureItem["temp"] as? Double
        
        if let icon, let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
            ImageDownloader.shared.downloadImage(from: url) { image in
                let iconImageView = cell.viewWithTag(1) as? UIImageView
                iconImageView?.image = image
            }
        }
        
        let descriptionLabel = cell.viewWithTag(2) as? UILabel
        descriptionLabel?.text = description ?? ""
        
        let captionLabel = cell.viewWithTag(3) as? UILabel
        if let linuxTime = forecast["dt"] as? TimeInterval, let temperature {
            let swiftDate = Date(timeIntervalSince1970: linuxTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd HH:mm"
            captionLabel?.text = "\(temperature)/\(formatter.string(from: swiftDate))"
        }
        
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
