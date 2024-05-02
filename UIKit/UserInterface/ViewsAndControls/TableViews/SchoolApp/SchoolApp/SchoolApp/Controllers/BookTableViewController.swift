//
//  BookTableViewController.swift
//  SchoolApp
//
//  Created by 한유진 on 5/1/24.
//

import UIKit
import Alamofire

class BookTableViewController: UITableViewController {
    var student: Student?
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let student else { return }
        title = "Books - \(student.name)"
        books(studentId: student.id)
    }

    func books(studentId sid: Int) {
        AF.request("http://localhost:3000/student/\(sid)/books").responseDecodable(of: BookRoot.self) { response in
            switch response.result {
            case .success(let root):
                self.books = root.documents
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let book = books?[indexPath.row] else { return cell }
        
        // Configure the cell...
        let titleLabel = cell.viewWithTag(1) as? UILabel
        titleLabel?.text = book.title
        let secondaryLabel = cell.viewWithTag(2) as? UILabel
        secondaryLabel?.text = "\(book.id)/\(book.author)"

        return cell
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as? AddBookViewController
        destination?.student = student
    }
    
    @IBAction func unwind2(segue: UIStoryboardSegue) {
        guard let student else { return }
        books(studentId: student.id)
    }
}
