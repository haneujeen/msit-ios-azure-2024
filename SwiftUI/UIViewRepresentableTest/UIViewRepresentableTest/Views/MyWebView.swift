//
//  MyWebView.swift
//  UIViewRepresentableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    @Binding var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
#Preview {
    MyWebView(url: .constant("https://google.com"))
}
