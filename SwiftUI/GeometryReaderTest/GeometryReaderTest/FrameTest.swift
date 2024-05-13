//
//  FrameTest.swift
//  GeometryReaderTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct FrameTest: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(.yellow)
            .frame(width: 100, height: 100, alignment: .center)
            .position(CGPoint(x: 300, y: 200))
    }
}

#Preview {
    FrameTest()
}
