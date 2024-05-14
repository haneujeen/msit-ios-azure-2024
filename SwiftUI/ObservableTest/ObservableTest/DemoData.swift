//
//  DemoData.swift
//  ObservableTest
//
//  Created by 한유진 on 5/14/24.
//

import Foundation
import SwiftUI

class DemoData: ObservableObject {
    @Published var userCount = 0
    @Published var newUser = ""
    
    init() {
        updateData()
    }
    
    func updateData() {
        userCount += 1
        newUser = "user\(userCount)"
    }
}

struct TestView: View {
    @StateObject var demoData = DemoData()
    
    var body: some View {
        VStack {
            Text("User count: \(demoData.userCount)")
            Text("New user: \(demoData.newUser)")
            
            Button {
                demoData.updateData()
            } label: {
                Text("Button")
            }
        }
    }
}

#Preview {
    TestView()
}
