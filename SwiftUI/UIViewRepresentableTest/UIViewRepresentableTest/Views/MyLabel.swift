//
//  MyLabel.swift
//  UIViewRepresentableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI
import UIKit

struct MyLabel: UIViewRepresentable {
    private let label = UILabel()
    @Binding var text: String
    
    func makeUIView(context: Context) -> UILabel {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) { 
        label.text = text
    }
}

#Preview {
    MyLabel(text: .constant("Label"))
}
