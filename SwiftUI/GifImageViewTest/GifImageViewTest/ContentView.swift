//
//  ContentView.swift
//  GifImageViewTest
//
//  Created by 한유진 on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GifImageView(name: "myGif")
            .frame(width: 40, height: 40)
    }
}

#Preview {
    ContentView()
}
