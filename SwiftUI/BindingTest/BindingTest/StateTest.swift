//
//  StateTest.swift
//  BindingTest
//
//  Created by 한유진 on 5/10/24.
//

import SwiftUI

struct StateTest: View {
    @State var isWifiEnabled = false
    @State var userName: String = ""
    var body: some View {
        WifiImageView(isWifiEnabled: $isWifiEnabled)
        Toggle(isOn: $isWifiEnabled, label: {
            Text("Enable Wi-Fi")
        })
        TextField("Enter user name: ", text: $userName)
        Text(userName)
    }
}

struct WifiImageView: View {
    @Binding var isWifiEnabled: Bool
    var body: some View {
        Image(systemName: isWifiEnabled ? "wifi" : "wifi.slash")
    }
}

#Preview {
    StateTest()
}
