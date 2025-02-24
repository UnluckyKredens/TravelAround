//
//  GenerateTravelView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/24/25.
//

import SwiftUI

struct GenerateTravelView: View {
    @State private var model: ReadyTravelModel = ReadyTravelModel(travelId: 0, imageUrl: "", name: "", description: "", price: 0, from: "", destination: "", members: 0, likes: 0)
   

    @State var fullscreen: Bool = false
    var body: some View {
        VStack {
            Text("Wygeneruj własną podróż")
            TextField("Skąd", text: $model.from).standardField()
            TextField("Dokąd", text: $model.destination).standardField()
            HStack {
                VStack(alignment: .leading) {
                    TextField("Budget", value: $model.price, format: .number).keyboardType(.decimalPad)
                }
                Divider()
                TextField("Ilosc osób", value: $model.members, format: .number)
            }.standardField()
            
            Button(action: {fullscreen.toggle()}) {
                Text("Generuj")
            }.PrimaryColorButton(width: 130, fontSize: 18).padding()
        }.padding(15).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray1, style: StrokeStyle(lineWidth: 1)).shadow(radius: 5)).padding(20)
            .fullScreenCover(isPresented: $fullscreen) {
                @State var userId = Int(UserDefaults.standard.string(forKey: "userId") ?? "")
                if(userId == nil) {
                    SimpleNavbar(fullscreen: $fullscreen)
                        UserAuthView()
                }else {
                    SimpleNavbar(fullscreen: $fullscreen)
                    ReadyTravelView(travel: model)
                }
            }
    }
}


#Preview {
    GenerateTravelView().font(.system(size: 18, weight: .thin))
}
