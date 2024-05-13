//
//  MyList.swift
//  ViewLifecycleTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct MyList: View {
    @State var data = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
//        List(data, id: \.self) { element in
//            Text(element)
//        }
        
        List {
            Toggle(isOn: .constant(true), label: {
                Text("Toggle")
            })
            
            EditButton()
            
            ForEach(data, id: \.self) { element in
                Text(element)
            }
            .onMove(perform: { indices, newOffset in
                data.move(fromOffsets: indices, toOffset: newOffset)
            })
            .onDelete(perform: { indexSet in
                data.remove(atOffsets: indexSet)
            })
        }.listStyle(.automatic)
    }
}

#Preview {
    MyList()
}
