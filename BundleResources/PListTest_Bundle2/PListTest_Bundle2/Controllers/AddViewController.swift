//
//  AddViewController.swift
//  PListTest_Bundle2
//
//  Created by 한유진 on 3/27/24.
//

import UIKit

class AddViewController: UIViewController {
    var parks: NSMutableArray?
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldCategory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        guard let name = textFieldName.text,
              let category = textFieldCategory.text,
              let city = textFieldCity.text
        else { return }
        let newPark = ["name": name,
                       "category": category,
                       "city": city,
                       "imageName": name.replacingOccurrences(of: " ", with: "").lowercased()]
        parks?.add(newPark)
        guard let url = urlWithFilename("parks.plist") else { return }
        try? parks?.write(to: url)
        
        // segue
        _ = navigationController?.popViewController(animated: true)
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
