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
            

                AsyncImage(url: URL(string: travel.imageUrl)){phase in
                    if let image = phase.image {
                       image.resizable().frame(height: 256)
                    }else if phase.error != nil {}
                    else {
                        ProgressView()
                    }
                }
                
            Text(travel.name)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 5.0)
                .frame(maxWidth: .infinity, alignment: .center)
            
                Text(String(travel.price) + " zł")
                .padding(.bottom)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            
            Divider()
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                Text(travel.description).padding(.top, 1.0)
            }.padding()
            
            Spacer()
        }
    }
}

#Preview {
    ReadyTravelsView(travel: ReadyTravelModel(travelId: 0, imageUrl: "", name: "axaxax", description: "dfgdfgdfgdfgklhdfjkghdfjkghdfjkgh", price: 120))
}
