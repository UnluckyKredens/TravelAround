//
//  UserPanelView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//

import SwiftUI

struct UserPanelView: View {
    @Binding var fullscreen: Bool
    
    init(fullscreen: Binding<Bool>) {
        self._fullscreen = fullscreen
    }
    var body: some View {
        Option(text: "Ulubione Wycieczki", icon: "heart.fill", destination: UserAuthView())
        Option(text: "Moje Wycieczki", icon: "bag.fill", destination: UserAuthView())
        Option(text: "Ustawienia Konta", icon: "gear", destination: UserAuthView())
        
        Spacer()
        Button(action: {UserDefaults.standard.removeObject(forKey: "userId"); fullscreen.toggle()}) {
            HStack {
                Image(systemName: "door.left.hand.open")
                Spacer()
                Text("Wyloguj się")
                Spacer()
            }
        }.PrimaryColorButton()
    }
}

private struct Option<Destination: View>: View {
    @State var text: String = ""
    @State var icon: String = ""
    @State var destination: Destination
    @State var fullscreen: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 32, weight: .thin))
//                .foregroundColor(.red)
            Text(text).font(.headline)
            Spacer()
        }.padding(.horizontal)
            .onTapGesture{fullscreen.toggle()}
            .fullScreenCover(isPresented: $fullscreen) {
                SimpleNavbar(fullscreen: $fullscreen)
                destination
            }
        Divider()
    }
}

#Preview {
    UserPanelView(fullscreen: .constant(true))
}
