//
//  ViewController.swift
//  UIAlertControllerTest
//
//  Created by 한유진 on 3/27/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let defaultAction = UIAlertAction(title: "Agree", style: .default) { _ in
            print("Ok")
        }
        let cancelAction = UIAlertAction(title: "Disagree", style: .cancel)
        
        let alert = UIAlertController(title: "Terms and Conditions",
                                      message: "Click Agree to accept the terms and conditions.",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        let defaultAction = UIAlertAction(title: NSLocalizedString("Save", comment: "Default action"), style: .default)
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let alert = UIAlertController(title: "My Alert", message: "", preferredStyle: .actionSheet)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addAction(destroyAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func actionSheetButtonTapped(_ sender: Any) {
        let defaultAction = UIAlertAction(title: "New Tab", style: .default) { (action) in
            self.label.text = "New Tab"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.label.text = "Cancel"
        }
        let destroyAction = UIAlertAction(title: "Close This Tab", style: .destructive) { (action) in
            self.label.text = "Close This Tab"
        }
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addAction(destroyAction)
        self.present(alert, animated: true)
    }
}

