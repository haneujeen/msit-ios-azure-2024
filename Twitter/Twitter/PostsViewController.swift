//
//  PostsViewController.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import UIKit
import Alamofire

class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let token = UserDefaults.standard.string(forKey: "token") {
            getPosts()
        } else {
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        guard let content = textField.text else { return }
        let params: Parameters = ["content": content]
        
        AF.request("http://localhost:3000/post/add",
                   method: .post,
                   parameters: params,
                   headers: headers
        ).responseDecodable(of: PostRoot.self) { response in
            switch response.result {
            case .success(let root):
                if root.success {
                    self.getPosts()
                    let indexPath = IndexPath(row: self.posts.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                } else {
                    self.showAlertWithSingleAction(message: root.message)
                }
            case .failure(let error):
                self.showAlertWithSingleAction(message: error.localizedDescription)
            }
        }
    }
    
    func getPosts() {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("http://localhost:3000/post",
                   method: .get,
                   headers: headers
        ).responseDecodable(of: PostRoot.self) { response in
            switch response.result {
            case .success(let root):
                if root.success {
                    self.posts = root.documents
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    self.showAlertWithSingleAction(message: root.message)
                }
            case .failure(let error):
                self.showAlertWithSingleAction(message: error.localizedDescription)
            }
        }
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

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        
        let userDateLabel = cell.viewWithTag(1) as? UILabel
        let contentLabel = cell.viewWithTag(2) as? UILabel
        userDateLabel?.text = "\(post.userId)"
        contentLabel?.text = post.content
        
        return cell
    }
}
