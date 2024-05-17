//
//  ViewController.swift
//  ControllerPresent
//
//  Created by 한유진 on 3/27/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionPresent(_ sender: Any) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "detail") else {
            return
        }
        present(controller, animated: true)
    }
    
}

