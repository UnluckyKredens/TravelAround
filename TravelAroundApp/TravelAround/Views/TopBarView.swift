//
//  TopBarView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import SwiftUI

struct TopBarView: View {
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            Spacer()
            Image("Logo").resizable().frame(width: 250, height: 80).padding(.leading, 10.0)
            Button(action: {}) {
            
                Image(systemName: "person.fill").foregroundStyle(.black).font(.title2)
            }.padding()
        }.frame(height: 60)
        Divider()
    }
}

#Preview {
    TopBarView()
}
