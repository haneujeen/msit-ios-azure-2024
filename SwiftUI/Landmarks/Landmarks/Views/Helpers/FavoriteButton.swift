//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by 한유진 on 5/13/24.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button(action: {
            isSet.toggle()
        }, label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .yellow : .gray)
        })
    }
}

#Preview {
    FavoriteButton(isSet: .constant(true))
}
