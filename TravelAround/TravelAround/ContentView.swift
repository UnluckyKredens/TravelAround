//
//  ContentView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/28/25.
//

import SwiftUI
struct ContentView: View {
    
    @State var userId: String = String(UserDefaults.standard.string(forKey: "userId") ?? "");
    @State var userFullscreen: Bool = false;
    @State var refreshTrigger: Bool = false;
    init() {
        getUserId()
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
                .onTapGesture {getUserId(); userFullscreen.toggle()}
                .fullScreenCover(isPresented: $userFullscreen, onDismiss: {getUserId()}) {
                    if(userId == "") {
                        SimpleNavbar(fullscreen: $userFullscreen)
                        UserAuthView()
                    }else {
                        SimpleNavbar(fullscreen: $userFullscreen)
                        UserPanelView(fullscreen: $userFullscreen)
                    }
                }
        }
        Divider()
        
        
        ScrollView {
            GenerateTravelView()
            SearchBar().padding()
            Text("Najpopularniejsze Wycieczki").font(.system(size: 22, weight: .thin))
            ReadyTravelsList().id(refreshTrigger)
            Text("Moje Wycieczki").font(.system(size: 22, weight: .thin))
            if(userId != "") {
                MyTravelsList().id(refreshTrigger)
            }else  {
                Image(systemName: "lock.fill").foregroundStyle(.gray1).font(.system(size: 32)).padding(2)
                Text("Zaloguj się aby zobaczyć swoje wycieczki")
            }
        }.refreshable {
            RefreshData()
        }
        .padding()
        Spacer()
    }
    
    func getUserId() {
        userId = String(UserDefaults.standard.string(forKey: "userId") ?? "");
    }
    
    func ClearId() {
        UserDefaults.standard.set("", forKey: "userId")
    }
    
    func RefreshData() {
        refreshTrigger.toggle()
    }
}


#Preview {
    ContentView().font(.system(size: 18, weight: .thin))
}
