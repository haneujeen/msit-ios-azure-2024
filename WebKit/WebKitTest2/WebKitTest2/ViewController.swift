//
//  ViewController.swift
//  WebKitTest2
//
//  Created by 한유진 on 3/27/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView?
    @IBOutlet weak var webViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        controller.add(self, name: "SendMessage")
        controller.add(self, name: "SayHello")
        controller.add(self, name: "SetUser")
        configuration.userContentController = controller
        
        webView = WKWebView(frame: webViewContainer.frame, configuration: configuration)

        self.view.addSubview(webView!)
        webView?.uiDelegate = self
        
        guard let url = URL(string: "http://127.0.0.1:8080") else { return }
        webView?.load(URLRequest(url: url))
    }
    
    @IBAction func action1(_ sender: Any) {
        webView?.evaluateJavaScript("call_func1()")
    }
    
    @IBAction func action2(_ sender: Any) {
        let param = "Turtle Rock"
        webView?.evaluateJavaScript("call_func2('\(param)')")
    }
    
    @IBAction func action3(_ sender: Any) {
        let park = ["name": "Turtle Rock", "category": "Rivers"]
        // Swift -> JS
        guard let data = try? JSONSerialization.data(withJSONObject: park),
              let param = String(data: data, encoding: .utf8)
        else { return }
        
        let script = "call_func3('\(param)')"
        
        // JS -> Swift
        webView?.evaluateJavaScript(script, completionHandler: { result, error in
            guard let result, let parkFromWeb = result as? [String:String] else {
                print(error!)
                return
            }
            print(parkFromWeb["name"]!)
        })
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "SendMessage": print("\(message.name): \(message.body)")
        case "SayHello": print("\(message.name): \(message.body)")
        case "SetUser":
            if let body = message.body as? [String:String] {
                print("\(message.name): \(body["name"]!)")
            }
        default: print("")
        }
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            completionHandler()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let defaultAction = UIAlertAction(title: "Agree", style: .default) { (action) in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "Disagree", style: .cancel) { (action) in
            completionHandler(false)
        }

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = defaultText
        }
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alert.textFields?[0].text {
                completionHandler(text != "" ? text : defaultText)
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
