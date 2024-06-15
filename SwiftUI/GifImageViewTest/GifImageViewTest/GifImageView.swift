//
//  GifImageView.swift
//  GifImageViewTest
//
//  Created by 한유진 on 6/13/24.
//

import SwiftUI
import SwiftyGif

struct GifImageView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("GIF not found")
            return
        }
        
        do {
            let gifData = try Data(contentsOf: URL(fileURLWithPath: gifPath))
            let gif = try UIImage(gifData: gifData)
            uiView.setGifImage(gif)
        } catch {
            print("Failed to load GIF: \(error)")
        }
    }
}
