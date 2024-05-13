//
//  TabViewTest.swift
//  ViewLifecycleTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct TabViewTest: View {
    var body: some View {
        TabView {
            MyView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("health")
                }
            
            Text("square.and.arrow.up.fill")
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("share")
                }
            
            Text("gear")
                .tabItem {
                    Image(systemName: "gear")
                    Text("settings")
                }
        }
    }
}

#Preview {
    TabViewTest()
}
