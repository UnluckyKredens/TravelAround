//
//  ReadyTravelsBox.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/16/24.
//

import SwiftUI

struct ReadyTravelsBox: View {
    var readyTravels: [ReadyTravelModel] = [
        ReadyTravelModel(id: 0, imageUrl: "https://cdn.britannica.com/14/94514-050-461B9A6D/Palm-trees-ocean-Bahamas-New-Providence-Island.jpg", name: "Tropical Paradise", description: "A tropical escape", date: "2024-12-12", price: 150),
        ReadyTravelModel(id: 1, imageUrl: "https://cdn.britannica.com/14/94514-050-461B9A6D/Palm-trees-ocean-Bahamas-New-Providence-Island.jpg", name: "Island Adventure", description: "Explore the wild", date: "2024-12-15", price: 250),
    ]
    
    @State private var selectedTravel: ReadyTravelModel? = nil

    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(self.readyTravels) { travel in
                    Button(action: {
                        selectedTravel = travel // Set selectedTravel to trigger fullScreenCover
                    }) {
                        VStack(alignment: .leading, spacing: 0) {
                            AsyncImage(url: URL(string: travel.imageUrl)) { image in
                                image.image?.resizable()
                            }
                            .frame(height: 90)
                            HStack {
                                Text(travel.name)
                                Spacer()
                                Text("$ " + String(travel.price))
                            }
                            .frame(height: 65)
                            .padding([.leading, .trailing], 8)
                            
                            .fontWidth(.condensed)
                        }
                        .frame(width: 150, height: 150, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 155)
        .fullScreenCover(item: $selectedTravel) { travel in
            VStack(alignment: .leading, spacing: 0) {
                VStack( spacing: 0) {
                    HStack {
                            Image(systemName: "arrow.left")
                            .onTapGesture(perform: {selectedTravel = nil})
                            .modifier(ActionImageModifier())
                            .frame(alignment: .leading)
                        Spacer()
                            Image(systemName: "plus")
                            .modifier(ActionImageModifier())
                            .frame(alignment: .trailing)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
                
                
            ReadyTravelsView(travel: travel).padding(0)
            }
        }
    }

struct ActionImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .frame(maxWidth: .infinity)
            .foregroundColor(.gray)
            .font(.title)
            .padding([.leading, .trailing], 15.0)
            .padding([.bottom], 10.0)
    }
}

#Preview {
    ReadyTravelsBox()
}
