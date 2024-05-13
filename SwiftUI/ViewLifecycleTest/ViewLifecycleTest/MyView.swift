//
//  MyView.swift
//  ViewLifecycleTest
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct MyView: View {
    @State var isShowText = true
    
    var body: some View {
        VStack {
            if isShowText {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .fontWeight(.black)
                    .padding(20)
                    .background(.yellow)
                    .onAppear(perform: {
                        print("onAppear")
                    })
                    .onDisappear(perform: {
                        print("onDisappear")
                    })
            }
            
            Toggle(isOn: $isShowText, label: {
                /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
            })
            .padding(20)
        }
    }
}

#Preview {
    MyView()
}
