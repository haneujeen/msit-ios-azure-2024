//
//  StateTest.swift
//  BindingTest
//
//  Created by 한유진 on 5/10/24.
//

import SwiftUI

struct StateTest: View {
    var body: some View {
        WifiImageView(isWifiEnabled: true)
    }
}

struct WifiImageView: View {
    var isWifiEnabled: Bool
    var body: some View {
        Image(systemName: isWifiEnabled ? "wifi" : "wifi.slash")
    }
}

#Preview {
    StateTest()
}
