//
//  LoadingView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/4/25.
//

import SwiftUICore
import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Ładowanie...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
            Text("Ładowanie danych...")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
