//
//  ReadyTravelsView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import SwiftUI

struct ReadyTravelsView: View {
    var travel: ReadyTravelModel
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: travel.imageUrl)){image in
                image.image?.resizable()
            }
            .frame(height: 256)
            
            
            HStack{
                Text(travel.name).padding().font(.title)
                Spacer()
                Text(travel.date).padding(.trailing).font(.title2)
            }
            
            HStack {
                Spacer()
                Text(String(travel.price) + " zł")
                    .padding([.bottom, .trailing])
                
            }
            
            Divider()
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                Text("Plan Wycieczki:").font(.headline)
                Text(travel.description).padding(.top, 1.0)
            }.padding()
            
            Spacer()
        }
    }
}

#Preview {
    ReadyTravelsView(travel: ReadyTravelModel(id: 0, imageUrl: "data:image/jpeg;base64,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", name: "axaxax", description: "dfgdfgdfgdfgklhdfjkghdfjkghdfjkgh", date: "2023.08.13", price: 120))
}