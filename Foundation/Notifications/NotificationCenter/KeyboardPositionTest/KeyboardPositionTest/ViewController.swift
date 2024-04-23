//
//  ViewController.swift
//  KeyboardPositionTest
//
//  Created by 한유진 on 4/18/24.
//

import UIKit

class ViewController: UIViewController {
    var origin: CGPoint?
    var originalSize: CGSize?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        origin = textField.frame.origin
        originalSize = textField.frame.size
        
        // Registering the observers
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            KeyboardManager.keyboardWillShow(notification: notification, textField: self?.textField, origin: self?.origin, originalSize: self?.originalSize)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] _ in
            KeyboardManager.keyboardWillHide(textField: self?.textField, origin: self?.origin, originalSize: self?.originalSize)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    }
}

