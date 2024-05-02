//
//  AddStudentViewController.swift
//  SchoolApp
//
//  Created by 한유진 on 5/1/24.
//

import UIKit
import Alamofire

class AddStudentViewController: UIViewController {
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var gradeTextfield: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        AF.request("http://localhost:3000/student",
                   method: .post,
                   parameters: [
                    "id": idTextfield.text ?? "",
                    "name": nameTextfield.text ?? "",
                    "major": majorTextfield.text ?? "",
                    "grade": gradeTextfield.text ?? "",
                    "gender": genderTextfield.text ?? ""
                   ]).responseDecodable(of: StudentRoot.self) { response in
                       print(response)
                       switch response.result {
                       case .success(let root):
                           if root.success {
                               self.showAlertWithSingleAction(message: root.message) { action in
                                   self.performSegue(withIdentifier: "unwindToStudents", sender: nil)
                               }
                           } else {
                               self.showAlertWithSingleAction(message: root.message)
                           }
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
    }
}

extension UIViewController {
    func showAlertWithSingleAction(title: String? = nil, message: String?, handler: ((UIAlertAction)->Void)? = nil) {
        let action = UIAlertAction(title: "Close", style: .default, handler: handler)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
