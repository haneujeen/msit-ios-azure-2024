//
//  BooksTableViewController.swift
//  KakaoAPITest
//
//  Created by 한유진 on 4/2/24.
//

import UIKit

class BooksTableViewController: UITableViewController {
    let apiKey = ProcessInfo.processInfo.environment["apiKey"] ?? ""
    var books: [[String:Any]]?
    var page = 1 {
        didSet {
            guard let searchBarText = searchBar.text else { return }
            createTask(query: searchBarText, page: page, size: 8)
            previousBarButton.isEnabled = page > 1
        }
    }
    
    @IBOutlet weak var previousBarButton: UIBarButtonItem!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func registerNib() {
        let nib = UINib(nibName: "BookNib", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "nib")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        self.title = "Kakao API Test"
        previousBarButton.isEnabled = false
        nextBarButton.isEnabled = false
    }
    
    func buildRequest(query: String, page: Int, size: Int) -> URLRequest {
        let endpoint = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=\(size)"
    
        guard let endpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: endpoint)
        else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func createTask(query: String, page: Int, size: Int) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: buildRequest(query: query, page: page, size: size)) { data, response, error in
            if let error { print(error.localizedDescription); return }
            
            guard let data else { return }
            guard let object = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
            
            self.books = object["documents"] as? [[String:Any]]
            
            guard let meta = object["meta"] as? [String:Any], 
                    let isEnd = meta["is_end"] as? Bool
            else { return }
            
            DispatchQueue.main.async {
                self.nextBarButton.isEnabled = !isEnd
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nib", for: indexPath) as! BookNib

        // Configure the cell...
        guard let book = books?[indexPath.row] else { return cell }
        
        guard let url = book["thumbnail"] as? String, let URL = URL(string: url) else { return cell }
        
        let request = URLRequest(url: URL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error { print(error) }
            guard let data else { return }
            DispatchQueue.main.async {
                cell.thumbnailImage.image = UIImage(data: data)
            }
        }.resume()
        cell.headLabel.text = book["title"] as? String
        
        let authors = book["authors"] as? [String]
        cell.subheadLabel.text = authors?.joined(separator: ", ")
        
        guard let price = book["price"] as? Int else { return cell}
        cell.priceLabel.text = "\(price)"

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BooksTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
}
