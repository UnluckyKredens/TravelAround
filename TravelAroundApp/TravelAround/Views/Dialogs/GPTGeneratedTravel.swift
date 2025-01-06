//
//  GPTGeneratedTravel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/4/25.
//

import SwiftUI

struct GPTGeneratedTravel: View {
    @State var from: String;
    @State var to: String;
    @State var budget: String;
    @State var members: String;
    @State var days: String;
    var response: String;
    var body: some View {
        Text("Wycieczka z \(from) do \(to) dla \(members) osób na \(days) dni")
            .padding()
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 5.0)
            .frame(maxWidth: .infinity, alignment: .center)
        
        Text("\(budget) zł")
            .padding(.bottom)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
        Divider()
        
        Text(response)
            .padding()
            .multilineTextAlignment(.center)
    }
    init(from: String, to: String, budget: String, members: String, days: String, response: String) {
        self.from = from
        self.to = to
        self.budget = budget
        self.members = members
        self.days = days
        self.response = response
    }
}


#Preview {
    GPTGeneratedTravel(from: "pkt. A", to: "pkt. B", budget: "X", members: "X", days: "X", response: "AAAAA")
}
