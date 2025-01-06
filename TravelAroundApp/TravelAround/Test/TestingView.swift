//
//  TestingView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/5/25.
//

import SwiftUI

struct TestingView: View {
    @State var userId = UserDefaults.standard.string(forKey: "userId") ?? "No value"
    var body: some View {
        Spacer()
        Text("UserId: \(userId)")
        Spacer()
        
        VStack {
            Button(action: {checkUserDefaults()}) {
                Text("Check UserDefaults")
            }
            Button(action: {clearUserDefaults()}) {
                Text("Clear UserDefaults")
            }
        }
        Spacer()

    }
}

func checkUserDefaults() {
    for(key, value) in UserDefaults.standard.dictionaryRepresentation() {
        print("Key: \(key) Value: \(value)")
    }
}

func clearUserDefaults() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
    print("UserDefaults cleared")
}

#Preview {
    TestingView()
}
