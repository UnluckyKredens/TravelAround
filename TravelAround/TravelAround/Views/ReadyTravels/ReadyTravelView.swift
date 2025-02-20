//
//  ReadyTravelView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/3/25.
//

import SwiftUI

struct ReadyTravelView: View {
    var travel: ReadyTravelModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: travel.imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 300)
                } else if phase.error != nil || phase.image == nil || travel.imageUrl.isEmpty {
                    Image(systemName: "rectangle.portrait.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 300)
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                        .frame(width: 150, height: 60)
                }
            }
            VStack {
                Text("Wycieczka z Krakowa do Warszawy").font(.system(size: 24, weight: .medium))
                Text("Cena").font(.system(size: 20, weight: .thin))
                Divider()
            }.frame(width: .infinity)
            
            HStack() {
                Atractions().frame(width: 190, height: 150)
                Divider()
                Extras().frame(width: 190, height: 150)
            }.frame(height: 150)
            Divider()
            Text("Opis")
            Spacer()
        }

    }
}

struct Atractions: View {
    var atrakcje = [["aa", 50], ]
    var body: some View {
        VStack {
            Text("Atrakcje")
            Divider()
            ScrollView {
                //Pętla
                HStack {
                    Text("Atrakcja1").padding(.leading)
                    Spacer()
                    Text("500m").font(.system(size: 14, weight: .light))
                        .padding(3)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(.buttonBorder)
                }
                Divider()
                
                
            }
        }

    }
}

struct Extras: View {
    var Dodatki = ["Jedzenie", "Wifi"]
    var body: some View {
        VStack {
            Text("Dodatki")
            Divider()
            ScrollView {
                //Pętla
                HStack {
                    Image(systemName: "plus").font(.system(size: 20, weight: .light))
                        .padding(3)
                        .background(Color.gray1)
                        .foregroundStyle(.white)
                        .clipShape(.buttonBorder)
                    Text("Atrakcja1").padding(.leading)
                    Spacer()
                }
                Divider()
                
                
            }
        }

    }
}

#Preview {
    ReadyTravelView(travel: ReadyTravelModel(travelId: 0, imageUrl: "", name: "", description: "", price: 0, from: "", destination: "", members: 0, likes: 0))
}
