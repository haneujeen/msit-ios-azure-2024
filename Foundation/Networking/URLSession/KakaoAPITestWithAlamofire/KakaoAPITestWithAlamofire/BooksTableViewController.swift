//
//  BooksTableViewController.swift
//  KakaoAPITestWithAlamofire
//
//  Created by 한유진 on 4/3/24.
//

import UIKit
import Alamofire
import Kingfisher

class BooksTableViewController: UITableViewController {
    let apiKey = "KakaoAK ec21690271bdc78663d5780d97cae11d"
    var books: [Document]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        createTask(query: "af", page: 1)
    }
    
    func createTask(query: String?, page: Int) {
        guard let query else { return }
        
        let endpoint = "https://dapi.kakao.com/v3/search/book"
        let params: Parameters = ["query": query, "page": page, "size": 8]
        let headers: HTTPHeaders = ["Authorization": apiKey]
        let alamo = AF.request(endpoint, method: .get, parameters: params, headers: headers)
        
        alamo.responseDecodable(of: Root.self) { response in
            switch response.result {
            case .success(let root):
                self.books = root.documents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
//            let root = response.value
//            self.books = root?.documents
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let book = books?[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        let headLabel = cell.viewWithTag(2) as? UILabel
        let authorsLabel = cell.viewWithTag(3) as? UILabel
        let priceLabel = cell.viewWithTag(4) as? UILabel
        
        imageView?.kf.setImage(with: URL(string: (book?.thumbnail)!))
        headLabel?.text = book?.title
        authorsLabel?.text = book?.authors.joined(separator: ", ")
        priceLabel?.text = "\((book?.price)!)"
        
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
