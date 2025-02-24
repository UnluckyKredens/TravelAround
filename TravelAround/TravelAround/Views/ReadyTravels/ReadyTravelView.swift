//
//  ReadyTravelView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/3/25.
//

import SwiftUI

struct ReadyTravelView: View {
    var travel: ReadyTravelModel? = nil
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: travel!.imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 300)
                } else if phase.error != nil || phase.image == nil || ((travel?.imageUrl.isEmpty) != nil) {
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
                Text(travel!.name).font(.system(size: 24, weight: .medium))
                Text("\(travel!.price) zł").font(.system(size: 20, weight: .thin))
                Divider()
            }.frame(width: .infinity)
            
            if(travel?.atractions?.count ?? -1 > 0) {
                HStack() {
                    Atractions(atractions: travel?.atractions ?? nil).padding(.horizontal) // jak cos to w:190 h 150 tak samo
    //                Divider()
    //                Extras().frame(width: 190, height: 150)
                }.frame(height: 150)
                Divider()
            }

            Text(travel!.description)
            Spacer()
        }

    }
}

struct Atractions: View {
    var atractions: [AtractionModel]? = []
    var body: some View {
        VStack {
            Text("Atrakcje")
            Divider()
            ScrollView {
                ForEach(atractions ?? []) {atraction in
                    HStack {
                        Text(atraction.name).padding(.leading)
                        Spacer()
                        Text(atraction.destination).font(.system(size: 14, weight: .light))
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
}

//struct Extras: View {
//    var Dodatki = ["Jedzenie", "Wifi"]
//    var body: some View {
//        VStack {
//            Text("Dodatki")
//            Divider()
//            ScrollView {
//                //Pętla
//                HStack {
//                    Image(systemName: "plus").font(.system(size: 20, weight: .light))
//                        .padding(3)
//                        .background(Color.gray1)
//                        .foregroundStyle(.white)
//                        .clipShape(.buttonBorder)
//                    Text("Atrakcja1").padding(.leading)
//                    Spacer()
//                }
//                Divider()
//                
//                
//            }
//        }
//
//    }
//}

#Preview {
    ReadyTravelView(travel: ReadyTravelModel(travelId: 0, imageUrl: "", name: "", description: "", price: 0, from: "", destination: "", members: 0, likes: 0))
}
