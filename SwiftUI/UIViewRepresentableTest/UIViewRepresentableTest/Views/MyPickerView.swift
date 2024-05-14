//
//  MyPickerView.swift
//  UIViewRepresentableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI
import PhotosUI

struct PickerTestView: View {
    @State private var image: UIImage?
    @State private var isPresented = false
    
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        
        Button {
            isPresented.toggle()
        } label: {
            Text("Button")
        }.sheet(isPresented: $isPresented, content: {
            MyPickerView(image: $image)
        })
    }
    
}

struct MyPickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: MyPickerView
        init(parent: MyPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self)
            else { return }
            
            provider.loadObject(ofClass: UIImage.self) { result, error in
                if let image = result as? UIImage {
                    self.parent.image = image
                }
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    //MyPickerView(image: .constant(UIImage(systemName: "star.fill")))
    PickerTestView()
}
