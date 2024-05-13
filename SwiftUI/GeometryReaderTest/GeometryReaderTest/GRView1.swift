//
//  GRView1.swift
//  GeometryReaderTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct GRView1: View {
    var body: some View {
        GeometryReader { reader in
            VStack {
                Text("Height: \(reader.size.height)")
                Text("Safe area top: \(reader.safeAreaInsets.top)")
            }
        }
    }
}

#Preview {
    GRView1()
}
