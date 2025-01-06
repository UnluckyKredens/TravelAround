//
//  TopBarView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import SwiftUI

struct TopBarView: View {
    @State var authView: Bool = false
    @State var LogedIn: Bool = false;
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            Spacer()
            Image("Logo").resizable().frame(width: 250, height: 80).padding(.leading, 10.0)
            Button(action: {isLoggedIn()}) {
            
                Image(systemName: "person.fill").foregroundStyle(.black).font(.title2)
            }.padding()
                .fullScreenCover(isPresented: $authView) {
                    CleanNavBarView(fullscreen: $authView)
                    UserAuthView()
                    
                }
                .fullScreenCover(isPresented: $LogedIn) {
                    CleanNavBarView(fullscreen: $LogedIn)

                }
        }.frame(height: 60)
        Divider()
    }
    
    func isLoggedIn() {
        let userId = UserDefaults.standard.string(forKey: "userId")
        if(userId == nil || userId == "") {
            authView.toggle()
        }else {
            authView = false
            LogedIn = true
            print("Juz zalogowane")
        }
    }
}



#Preview {
    TopBarView()
}
