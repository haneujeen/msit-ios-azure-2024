//
//  ViewController.swift
//  WebKitTest
//
//  Created by 한유진 on 3/27/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button1(_ sender: Any) {
        guard let url = URL(string: "https://apple.com") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction func button2(_ sender: Any) {
        guard let url2 = URL(string: "https://google.com") else { return }
        webView.load(URLRequest(url: url2))
    }
    
    @IBAction func button3(_ sender: Any) {
        guard let url3 = URL(string: "http://github.com") else { return }
        webView.load(URLRequest(url: url3))
    }
}

