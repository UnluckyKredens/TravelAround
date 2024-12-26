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
            
            Text("Best ready propositions")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
                .font(.headline)
            
            ReadyTravelsBox().padding()
            Spacer()
            GenerateTravelBox().padding()
            
        }.frame(height: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}
