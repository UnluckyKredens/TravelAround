//
//  MyTravelsList.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/1/25.
//

import SwiftUI

struct MyTravelsList: View {
    @State private var ReadyTravels: [ReadyTravelModel] = []
    
    @State var selectedTravel: ReadyTravelModel? = nil
    @State var isLoading: Int = 1
    @State var errorMessage: String = "";
    private var travelService = TravelService()
    
    var body: some View {
        HStack {
            if isLoading == 1 {
                ProgressView("Loading...")
            }
            else if isLoading == -1 {
                VStack {
                    Image(systemName: "x.circle").foregroundStyle(.red).font(.system(size: 32)).padding(2)
                    Text("Coś poszło nie tak").font(.system(size: 18, weight: .light))
                }.frame(height: 180)
            }
            else {
                if(ReadyTravels.count == 0) {
                    VStack(alignment: .center) {
                        Image(systemName: "plus").foregroundStyle(.gray1)
                            .font(.system(size: 32)).padding(2)
                        Text("Jeszcze nie masz swoich podróży \nStwórz ją").multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .light))
                    }
                }else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                            ForEach(ReadyTravels) { travel in
                                Card(travel: travel, selectedTravel: selectedTravel)
                            }.frame(height: 230, alignment: .center)
                        }
                        
                    }
                }
            }
        }.task {
            await DownloadData()
        }
        
    }
    
    func DownloadData() async {
        do {
            ReadyTravels = try await travelService.DownloadMyTravels()
            isLoading = 0
        }catch {
            isLoading = -1
            errorMessage = error.localizedDescription
        }
    }
}



#Preview {
    MyTravelsList().font(.system(size: 18, weight: .thin))
}
