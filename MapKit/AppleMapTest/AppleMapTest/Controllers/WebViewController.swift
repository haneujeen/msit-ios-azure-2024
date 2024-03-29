//
//  WebViewController.swift
//  AppleMapTest
//
//  Created by 한유진 on 3/29/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var mapURL: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mapURL, let url = URL(string: mapURL) else { return }
        webView.load(URLRequest(url: url))
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
