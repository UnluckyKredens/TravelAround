//
//  ContentView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        ScrollView() {
                TopBarView()
                        
            ReadyTravelsBox().padding()
            Spacer()
            GenerateTravelBox().padding()
            
            
        }
    }
}

#Preview {
    ContentView()
}
