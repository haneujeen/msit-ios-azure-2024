//
//  DetailViewController.swift
//  PListTest_Bundle2
//
//  Created by 한유진 on 3/27/24.
//

import UIKit

class DetailViewController: UIViewController {
    var park: [String:String]?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let park else { return }
        if let imageName = park["imageName"] {
            imageView.image = UIImage(named: imageName)
        }
        label1.text = park["name"]
        label2.text = park["city"]
        label3.text = park["category"]
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
