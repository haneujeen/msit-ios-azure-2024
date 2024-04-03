//
//  BooksTableViewController.swift
//  KakaoAPITest
//
//  Created by 한유진 on 4/2/24.
//

import UIKit

class BooksTableViewController: UITableViewController {
    let apiKey = "KakaoAK ec21690271bdc78663d5780d97cae11d"
    var books: [[String:Any]]?
    
    func registerNib() {
        let nib = UINib(nibName: "BookNib", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "nib")
    }
    
    func buildRequest(query: String, page: Int, size: Int) -> URLRequest {
        let endpoint = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=\(size)"
        
        guard let endpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: endpoint)
        else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func createTask(query: String, page: Int, size: Int) {
        let session = URLSession.shared
        let task = session.dataTask(with: buildRequest(query: query, page: page, size: size)) { data, response, error in
            if let error { print(error.localizedDescription); return }
            
            guard let data else { return }
            guard let object = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
            
            self.books = object["documents"] as? [[String:Any]]
            
            guard let meta = object["meta"] as? [String:Any], let isEnd = meta["is_end"] as? Bool else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        registerNib()
        createTask(query: "해리포터", page: 1, size: 1)
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
        
        cell.headLabel.text = book["title"] as? String
        
        let authors = book["authors"] as? [String]
        cell.subheadLabel.text = authors?.joined(separator: ", ")
        
        guard let price = book["price"] as? Int else { return cell}
        cell.priceLabel.text = "\(price)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
