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
    let apiKey = ProcessInfo.processInfo.environment["apiKey"] ?? ""
    var books: [Document]?
    var isEnd: Bool?
    var page = 0 {
        didSet {
            leftBarButton.isEnabled = page > 1
            createTask(query: searchBar.text, page: page)
        }
    }
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createTask(query: String?, page: Int) {
        guard let query else { return }
        
        let endpoint = "https://dapi.kakao.com/v3/search/book"
        let params: Parameters = ["query": query, "page": page, "size": 8]
        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
        let alamo = AF.request(endpoint, method: .get, parameters: params, headers: headers)
        
        alamo.responseDecodable(of: Root.self) { response in
            switch response.result {
            case .success(let root): // .success(Root): Result<Root, AFError>
                self.books = root.documents
                self.isEnd = root.meta.isEnd
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.rightBarButton.isEnabled = !(self.isEnd ?? false)
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

    @IBAction func previousAction(_ sender: Any) {
        page -= 1
    }
    
    @IBAction func nextAction(_ sender: Any) {
        page += 1
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
        
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ToWebView", sender: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWebView" {
            // Get the new view controller using segue.destination.
            guard let controller = segue.destination as? WebViewViewController else { return }
            
            // Pass the selected object to the new view controller.
            guard let indexPath = sender as? IndexPath,
                  let book = books?[indexPath.row] else { return }
                  
            controller.url = URL(string: book.url)
        }
    }
}

extension BooksTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
}
