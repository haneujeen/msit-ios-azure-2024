//
//  SignInViewController.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        guard let id = idTextField.text,
              let password = passwordTextField.text
        else { return }
        
        AF.request("http://localhost:3000/auth/sign-in",
                   method: .post,
                   parameters: [
                    "userId": id,
                    "password": password
                   ]).responseDecodable(of: Token.self) { response in
                       switch response.result {
                       case .success(let root):
                           if root.success {
                               print(root.token!)
                           } else {
                               self.showAlertWithSingleAction(message: root.message)
                           }
                       case .failure(let error):
                           self.showAlertWithSingleAction(message: error.localizedDescription)
                       }
                   }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
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
