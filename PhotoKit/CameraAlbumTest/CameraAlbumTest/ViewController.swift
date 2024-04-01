//
//  ViewController.swift
//  CameraAlbumTest
//
//  Created by 한유진 on 4/1/24.
//

import UIKit

class ViewController: UIViewController {
    let camera = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        camera.sourceType = .camera
        camera.delegate = self
    }

    @IBAction func showActions(_ sender: Any) {
        let sheet = UIAlertController(title: "Actions", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.present(self.camera, animated: true)
        }
        
        sheet.addAction(cancelAction)
        sheet.addAction(cameraAction)
        present(sheet, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true)
    }
}
