//
//  TravelSearchResult.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/20/25.
//

import SwiftUI

struct TravelSearchResult: View {
    @State var travels: [ReadyTravelModel] = []
    @State var searchedText: String = "s"
    @State var selectedTravel: ReadyTravelModel? = nil
    
    var body: some View {
        ScrollView {
            ForEach(travels) { travel in
                
                HStack {
                    Button(action: {selectedTravel = travel}) {
                        HStack {
                            AsyncImage(url: URL(string: travel.imageUrl)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 100)
                                } else if phase.error != nil || travel.imageUrl.isEmpty {
                                    Image(systemName: "rectangle.portrait.slash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 60)
                                        .foregroundColor(.gray)
                                } else {
                                    ProgressView()
                                        .frame(width: 64, height: 60)
                                }
                            }
                            VStack {
                                Text(travel.name)
                                Text(travel.destination)
                                    .font(.system(size: 14, weight: .thin))
                                    .padding(.top, 1.0)
                                
                            }
                            Spacer()
                            Text(String(travel.price) + " zł")
                        }.onTapGesture {
                            selectedTravel = travel
                        }
                    }.foregroundStyle(.black)
                    
                    VStack {
                        Image(systemName: "heart").foregroundStyle(.red)
                        Text(String(travel.likes))
                    }.padding()
                }
                Divider()
                
            }.onAppear() {
                Task {
                    await FindTravels()
                }
            }
        }
        .fullScreenCover(item: $selectedTravel) { travel in
            TravelNavbar(selectedTravel: $selectedTravel)
            ReadyTravelView(travel: travel)
        }
    }
    
    
    func FindTravels() async {
        do {
            travels = try await TravelService().FindTravelsByDestination(destination: searchedText)
        }
        catch {
        }
    }
}

#Preview {
    TravelSearchResult().font(.system(size: 18, weight: .thin))
}
