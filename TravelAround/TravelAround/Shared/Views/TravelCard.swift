//
//  TravelCard.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/17/25.
//

import SwiftUICore
import SwiftUI

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
