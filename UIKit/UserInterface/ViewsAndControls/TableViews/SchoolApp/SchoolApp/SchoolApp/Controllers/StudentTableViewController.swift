//
//  StudentTableViewController.swift
//  SchoolApp
//
//  Created by 한유진 on 5/1/24.
//

import UIKit
import Alamofire

class StudentTableViewController: UITableViewController {
    var students: [Student]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Students"

        getStudents()
    }
    
    func getStudents() {
        AF.request("http://localhost:3000/student").responseDecodable(of: StudentRoot.self) { response in
            switch response.result {
            case .success(let root):
                if root.success {
                    self.students = root.documents
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print(root.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let student = students?[indexPath.row] else { return cell }
        
        // Configure the cell...
        let nameLabel = cell.viewWithTag(1) as? UILabel
        nameLabel?.text = student.name
        let secondaryLabel = cell.viewWithTag(2) as? UILabel
        secondaryLabel?.text = "\(student.id)/\(student.gender)/\(student.grade)/\(student.major ?? "")"

        return cell
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let selected = tableView.indexPathForSelectedRow,
              let student = students?[selected.row]
        else { return }
        
        // Pass the selected object to the new view controller.
        let destination = segue.destination as? BookTableViewController
        destination?.student = student
    }
    
    @IBAction func unwind1(segue: UIStoryboardSegue) {
        getStudents()
    }

}
