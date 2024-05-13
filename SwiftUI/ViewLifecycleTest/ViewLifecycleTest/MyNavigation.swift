//
//  MyNavigation.swift
//  ViewLifecycleTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct MyNavigation: View {
    @State var data = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(data, id: \.self) { element in
                    NavigationLink(destination: Text(element)) {
                        Text(element)
                    }
                }
            }
            .navigationTitle("My Navigation")
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    MyNavigation()
}
