//
//  AddBookViewController.swift
//  SchoolApp
//
//  Created by 한유진 on 5/1/24.
//

import UIKit
import Alamofire

class AddBookViewController: UIViewController {
    var student: Student?
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var authorTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func book(studentId sid: Int) {
        AF.request("http://localhost:3000/book",
                   method: .post,
                   parameters: [
                    "id": idTextfield.text ?? "",
                    "title": titleTextfield.text ?? "",
                    "author": authorTextfield.text ?? "",
                    "sid": sid
                   ]).responseDecodable(of: BookRoot.self) { response in
                       switch response.result {
                       case .success(let root):
                           if root.success {
                               self.showAlertWithSingleAction(message: root.message) { action in
                                   self.performSegue(withIdentifier: "unwindToBooks", sender: nil)
                               }
                           } else {
                               self.showAlertWithSingleAction(message: root.message)
                           }
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let student else { return }
        book(studentId: student.id)
    }
}
