//
//  MyTravelsList.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/1/25.
//

import SwiftUI

struct MyTravelsList: View {
    var ReadyTravels: [ReadyTravelModel] = [
        ReadyTravelModel(travelId: 1, imageUrl: "https://imageio.forbes.com/specials-images/imageserve/647facd9f5654bc6b057b386/Couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island/960x0.jpg?format=jpg&width=960", name: "AAA", description: "CCC", price: 20.00),
        ReadyTravelModel(travelId: 2, imageUrl: "https://imageio.forbes.com/specials-images/imageserve/647facd9f5654bc6b057b386/Couple-relax-on-the-beach-enjoy-beautiful-sea-on-the-tropical-island/960x0.jpg?format=jpg&width=960", name: "VVV", description: "CCC", price: 20.00)
        
    ]
    var selectedTravel: ReadyTravelModel? = nil
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(ReadyTravels) { travel in
                    Card(travel: travel, selectedTravel: selectedTravel)
                }.frame(height: 230, alignment: .center)
            }
        }
    }
}

struct Card: View {
    let travel: ReadyTravelModel
    @State var selectedTravel: ReadyTravelModel? = nil
    var body: some View {
        Button(action: { selectedTravel = travel }) {
            VStack {
                AsyncImage(url: URL(string: travel.imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 100)
                    } else if phase.error != nil || travel.imageUrl.isEmpty {
                        Image(systemName: "rectangle.portrait.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                            .frame(width: 150, height: 60)
                    }
                }
                .frame(width: 150, height: 130)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack {
                    Text(travel.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(String(format: "%.2f", travel.price)) zł")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 4)
            }
            .frame(width: 120, height: 180)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
        }            .fullScreenCover(item: $selectedTravel, content: { travel in
            TravelNavbar(selectedTravel: $selectedTravel)
            ReadyTravelView(travel: travel)
        })
    }
}

#Preview {
    MyTravelsList()
}
