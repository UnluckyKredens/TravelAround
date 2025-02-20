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
    private var travelService = TravelService()
    
    var body: some View {
        HStack {
            if isLoading == 1 {
                ProgressView("Loading...")
            }
            else if isLoading == -1 {
                VStack {
                    Image(systemName: "x.circle").foregroundStyle(.red).font(.system(size: 32)).padding(2)
                    Text("No internet connection").font(.system(size: 18, weight: .light))
                }.frame(height: 180)
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(ReadyTravels) { travel in
                            Card(travel: travel, selectedTravel: selectedTravel)
                        }.frame(height: 230, alignment: .center)
                    }
                }
            }
        }.task {
        }
        
    }
    
    func DownloadData() {
        do {
            
        }catch {
            
        }
    }
}



#Preview {
    MyTravelsList()
}
