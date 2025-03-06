//
//  SimpleNavbar.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//

import SwiftUI

struct SimpleNavbar: View {
    @Binding var fullscreen: Bool;
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .padding(.leading, 15.0)
                .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                .onTapGesture {
                    self.fullscreen.toggle()
                }
            Spacer()
            Image("Logo").resizable().frame(width: 210, height: 64)
            Spacer()
            Spacer()
        }.frame(height: 64)
    }
}

struct TravelNavbar: View {
    @Binding var selectedTravel: ReadyTravelModel?;
    @State var userId = Int(UserDefaults.standard.string(forKey: "userId") ?? "") ?? 0;
    @State var liked: Int = 0;
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .padding(.leading, 15.0)
                .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                .onTapGesture {
                    selectedTravel = nil
                }
            Spacer()
            Image("Logo").resizable().frame(width: 210, height: 64)
            Spacer()
            
            if(liked == 1) {
                Image(systemName: "heart.fill")
                    .padding(.trailing, 15.0)
                    .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                    .foregroundStyle(.red)
                    .onTapGesture {
                        Task {
                            await DeleteFavourite()
                            withAnimation(.spring) {
                                liked -= 1
                            }
                        }
                    }
                    .transition(.scale(scale: 0.5))
            }else if(liked == 0) {
                Image(systemName: "heart")
                    .padding(.trailing, 15.0)
                    .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                    .onTapGesture {
                        Task {
                            await MakeFavourite()
                            withAnimation(.spring) {
                                liked += 1
                            }
                        }
                    }
            }else {
                
            }
            
        }.frame(height: 64)
            .onAppear() { Task {
                liked = await checkFavourite(travel: selectedTravel!)
            }
                
            }
    }
    
    func MakeFavourite() async {
        _ = try! await FavouriteTravelService().MakeTravelFavourite(userId: userId, travelId: selectedTravel!.travelId)
        _ = await checkFavourite(travel: selectedTravel!)
    }
    
    func DeleteFavourite() async {
        _ = try! await FavouriteTravelService().DeleteFavouriteTravel(userId: userId, travelId: selectedTravel!.travelId)
        _ = await checkFavourite(travel: selectedTravel!)
    }
    
    func checkFavourite(travel: ReadyTravelModel) async -> Int{
        if(userId != 0) {
            do {
                let likedTravels: [Int] = try await FavouriteTravelService().GetFavouriteTravels(userId: userId)
                
                if (likedTravels.contains(travel.travelId)){
                    return 1
                }else {
                    return 0
                }
            }catch {
                return -1
            }
        }
        return -1
    }
}

#Preview {
    @Previewable @State var fullscreenV: Bool = true;
    @Previewable @State var selectedTravel: ReadyTravelModel? = ReadyTravelModel(travelId: 1, imageUrl: "", days: 0, name: "", description: "", price: 0, from: "", destination: "", members: 0, likes: 0)
    SimpleNavbar(fullscreen: $fullscreenV)
    TravelNavbar(selectedTravel: $selectedTravel)
}
