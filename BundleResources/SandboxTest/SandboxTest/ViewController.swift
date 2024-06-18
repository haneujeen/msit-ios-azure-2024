//
//  ViewController.swift
//  SandboxTest
//
//  Created by 한유진 on 6/18/24.
//

import UIKit
import PhotosUI

// MARK: - Main setup
class ViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    var picker: PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        picker = PHPickerViewController(configuration: configuration)
        picker?.delegate = self
    }
    
    @IBAction func getBundleAction(_ sender: Any) {
        print(Bundle.main.bundlePath)
    }
    
    @IBAction func writeNSArrayAction(_ sender: Any) {
        let array = NSMutableArray()
        array.add(NSDictionary(dictionary: ["A": "b"]))
        
        do {
            try array.write(to: fileURL("filename.plist", type: .propertyList))
        } catch {
            print(error)
        }
    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        guard let image = myImageView.image, let imageData = image.pngData() else { return }
        
        do {
            try imageData.write(to: fileURL("savedImage.png", type: .png))
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let photoAlbumAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
            guard let picker = self.picker else { return }
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(cameraAction)
        alert.addAction(photoAlbumAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) { }
    }
}

// MARK: - UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            myImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self)
        else { return }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            guard let self = self, let image = image as? UIImage else { return }
            DispatchQueue.main.async {
                self.myImageView.image = image
            }
        }
    }
}
