//
//  TravelAroundApp.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/28/25.
//

import SwiftUI

@main
struct TravelAroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.font, Font.custom("Inter-Regular_ExtraLight", size: 18).weight(.thin))
        }
    }
}
