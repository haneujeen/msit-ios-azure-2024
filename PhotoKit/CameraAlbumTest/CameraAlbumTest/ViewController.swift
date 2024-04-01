//
//  ViewController.swift
//  CameraAlbumTest
//
//  Created by 한유진 on 4/1/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    let camera = UIImagePickerController()
    var picker: PHPickerViewController?
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
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("MyValue", forKey: "myKey")
        userDefaults.setValue(10, forKey: "myInt")
        
        let myValue = userDefaults.string(forKey: "myKey")
        let myInt = userDefaults.integer(forKey: "myInt")
    }

    @IBAction func showActions(_ sender: Any) {
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
    
    @IBAction func saveImage(_ sender: Any) {
        guard
            let image = imageView.image,
            let data = image.jpegData(compressionQuality: 0.8)
        else { return }
        
        do {
            try data.write(to: urlWithFilename("flower", type: .png))
        } catch {
            print(error) // Alert
        }
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

extension ViewController: PHPickerViewControllerDelegate {
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
