//
//  ContentView.swift
//  UIViewRepresentableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State var text: String = "My Label"
    @State var url: String = "https://google.com"
    
    var body: some View {
        VStack {
            MyLabel(text: $text)
            MyWebView(url: $url)
            
            HStack {
                Button {
                    url = "https://google.com"
                } label: {
                    Text("Button 1").font(.title2)
                }
                
                Button {
                    url = "https://apple.com"
                } label: {
                    Text("Button 2").font(.title2)
                }
            }
            

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
