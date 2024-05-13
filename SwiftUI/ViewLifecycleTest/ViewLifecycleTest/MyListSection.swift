//
//  MyListSection.swift
//  ViewLifecycleTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct MyListSection: View {
    @State var data = ["Item 1", "Item 2", "Item 3"]
    @State var isExpanded = true
    
    var body: some View {
        List {
            Toggle(isOn: $isExpanded, label: {
                Text("Label")
            })
            
            Section {
                ForEach(data, id: \.self) { element in
                    Text(element)
                }
            } header: {
                Text("Section Header")
                    .font(.headline)
            } footer: {
                Text("Section Footer")
            }

            Section {
                ForEach(data, id: \.self) { element in
                    Text(element)
                }
            }
            
            Section(isExpanded: $isExpanded) {
                ForEach(data, id: \.self) { element in
                    Text(element)
                }
            } header: {
                Text("Expandable Section Header")
            }
        }.listStyle(.sidebar)
    }
}

#Preview {
    MyListSection()
}
