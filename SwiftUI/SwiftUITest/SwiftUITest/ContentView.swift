//
//  ContentView.swift
//  SwiftUITest
//
//  Created by 한유진 on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    var framework = "Hello, UIKit"
    var body: some View {
        VStack {
            Text(framework)
                .font(.title)
            Button(action: {
                framework = "Hello, SwiftUI"
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
    }
}

#Preview {
    ContentView()
}
