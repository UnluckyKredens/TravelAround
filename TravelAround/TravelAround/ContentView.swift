//
//  ContentView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/28/25.
//

import SwiftUI
struct ContentView: View {
    
    @State var userId: String = "";
    @State var userFullscreen: Bool = false;
    init() {
        userId = String(UserDefaults.standard.string(forKey: "userId") ?? "");
    }
    
    
    var body: some View {
            HStack {
                if(userId != "") {
                    Image(systemName: "plus").padding(.leading).font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Image("Logo").resizable().frame(width: 210, height: 64)
                Spacer()
                Image(systemName:"person")
                    .padding(.trailing)
                    .font(.system(size: 24, weight: .thin))
                    .onTapGesture {userFullscreen.toggle()}
                    .fullScreenCover(isPresented: $userFullscreen) {
                    if(userId == "") {
                        SimpleNavbar(fullscreen: $userFullscreen)
                        UserAuthView() // $userId, $userFullscreen
                    }else {
                        UserPanelView() // $userFullScreen
                    }
                }
            }
        Divider()
            ScrollView {
                SearchBar().padding()
                Text("Najpopularniejsze Wycieczki").font(.system(size: 22, weight: .thin))
                ReadyTravelsList()
                Text("Moje Wycieczki").font(.system(size: 22, weight: .thin))
                MyTravelsList()
            }
            .padding()
            Spacer()
        }
    }

#Preview {
    ContentView()
}
