//
//  EnvironmentObjectTest.swift
//  ObservableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI

struct EnvironmentObjectTest: View {
    var demoData = DemoData()
    
    var body: some View {
        VStack {
            ObjectView1()
            
            Divider()
            
            ObjectView2()
        }
        .environmentObject(demoData)
    }
}

struct ObjectView1: View {
    @EnvironmentObject var demoData: DemoData
    
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

struct ObjectView2: View {
    @EnvironmentObject var demoData: DemoData
    
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
    EnvironmentObjectTest()
}
