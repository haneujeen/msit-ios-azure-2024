//
//  SignUpViewController.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import UIKit
import Alamofire
import PhotosUI

class SignUpViewController: UIViewController {
    let camera = UIImagePickerController()
    var picker: PHPickerViewController?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        camera.sourceType = .camera
        camera.delegate = self
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        picker = PHPickerViewController(configuration: config)
        picker?.delegate = self
    }
    
    @IBAction func selectPhotoButton(_ sender: Any) {
        let sheet = UIAlertController(title: "Actions", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.present(self.camera, animated: true)
        }
        let pickerAction = UIAlertAction(title: "Album", style: .default) { _ in
            self.present(self.picker!, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        sheet.addAction(cameraAction)
        sheet.addAction(pickerAction)
        sheet.addAction(cancelAction)
        present(sheet, animated: true)
    }
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let id = idTextField.text,
              let name = nameTextField.text,
              let password = passwordTextField.text,
              let image = imageView.image
        else { return }
        
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        let params = ["userId": id, "userName": name, "password": password]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
//            multipartFormData.append(id.data(using: .utf8)!, withName: "userId")
//            multipartFormData.append(name.data(using: .utf8)!, withName: "userName")
//            multipartFormData.append(password.data(using: .utf8)!, withName: "password")
            multipartFormData.append(image.pngData()!, withName: "image", fileName: "image.png", mimeType: "image/png")
        }, to: "http://localhost:3000/auth/sign-up", headers: headers).responseDecodable(of: UserRoot.self) { response in
            switch response.result {
            case .success(let root):
                if root.success {
                    self.showAlertWithSingleAction(message: root.message) { action in
                        self.dismiss(animated: true)
                        // Unwind
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

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true)
    }
}

extension SignUpViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        provider.loadObject(ofClass: UIImage.self) { result, error in
            if let image = result as? UIImage {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        picker.dismiss(animated: true)
    }
}
