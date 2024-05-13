//
//  GRTest.swift
//  GeometryReaderTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct GRTest: View {
    var body: some View {
        GeometryReader { reader in
            VStack {
                GRView1()
                    .frame(height: reader.size.height/4)
                GRView2()
                    .frame(height: reader.size.height/3)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GRTest()
}
