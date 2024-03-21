//
//  DetailViewController.swift
//  TodoAppWithSegue
//
//  Created by 한유진 on 3/21/24.
//

import UIKit

class DetailViewController: UIViewController {
    var item: String?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let item else { return }
        label.text = item
    }
    
    func receiveItem(_ item: String) {
        self.item = item
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
