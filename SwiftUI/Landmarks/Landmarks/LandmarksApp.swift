//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 한유진 on 5/10/24.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
