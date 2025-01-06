//
//  ReadyTravelsBox.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/16/24.
//

import SwiftUI

struct ReadyTravelsBox: View {
    
    @State private var readyTravels: [ReadyTravelModel] = []
    @State private var selectedTravel: ReadyTravelModel? = nil
    @State private var apiIsLoaded: Bool = false
    @State private var liked: Bool = false
    @State private var errorMessage: String?
    
    private let apiService = ReadyTravelService()
    var body: some View {
        Text("Gotowe propozycje")
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
            .font(.headline)
        Group {
            if let errorMessage = errorMessage {
                Text(errorMessage).foregroundStyle(.red)
            }else {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(self.readyTravels) { travel in
                            Button(action: {
                                selectedTravel = travel
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
                }.onAppear{loadAPI()}
                    .frame(height: 155)
                    .fullScreenCover(item: $selectedTravel) {travel in
                        VStack {
                            HStack {
                                Button(action: {
                                    selectedTravel = nil
                                }) {
                                    Image(systemName: "arrow.left")
                                        .frame(alignment:.leading)
                                        .foregroundStyle(Color.gray)
                                        .font(.title)
                                        .padding([.leading, .bottom], 10.0)
                                }
                                Spacer()
                                
                                Spacer()
                                if(liked) {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(Color.red)
                                        .modifier(ActionImageModifier())
                                        .onTapGesture {liked = false}
                                }else {
                                    Image(systemName: "heart")
                                        .modifier(ActionImageModifier())
                                        .onTapGesture {liked = true}
                                }
                            }.padding()
                            Divider()
                        }
                        
                        ReadyTravelsView(travel: travel).padding(0)
                    }
            }
        }
    }
    
    private func loadAPI() {
        Task {
            do {
                readyTravels = try await apiService.GetAllTravels()
            }
            catch {
                errorMessage = "Nie udało się pobrać danych: \(error.localizedDescription)"
                print(error.localizedDescription)
            }
        }
    }
}





#Preview {
    ReadyTravelsBox()
}
