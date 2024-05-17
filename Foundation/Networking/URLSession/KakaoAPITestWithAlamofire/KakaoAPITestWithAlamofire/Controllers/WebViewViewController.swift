//
//  WebViewViewController.swift
//  KakaoAPITestWithAlamofire
//
//  Created by 한유진 on 4/3/24.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    var url: URL?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let url else { return }
        webView.load(URLRequest(url: url))
    }
}
