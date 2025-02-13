//
//  UserAuthView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//

import SwiftUI

struct UserAuthView: View {
    var description: [String] = [
        "Znajdź wycieczkę idealną dla siebie szybko i łatwo!",
        "Znajdź wymarzoną wycieczkę w kilka kliknięć!",
        "Twoja idealna wycieczka na wyciągnięcie ręki!",
        "Podróże dopasowane do ciebie",
        "Twoja wymarzona wycieczka czeka- odkryj ją z nami!",
        "Przygoda zaczyna się tutaj. Wybierz kierunek, a my dopasujemy wycieczkę do Twoich potrzeb."
    ]
    var picture: [String] = ["plus", "minus", "rectangle.portrait.slash", "heart.slash.circle.fill", "drop.degreesign.slash", "rectangle.portrait.slash"]
    @State var index: Int;
    
    init() {
        index = Int.random(in: 0 ..< description.count)
    }
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                VStack {
                    Image(systemName: picture[index]).padding().font(.system(size: 40))
                    Text(description[index]).multilineTextAlignment(.center)
                }
                .frame(height: 300, alignment: .center)
                .padding()
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                        withAnimation(.easeIn(duration: 0.4)) {
                            index = (index + 1 ) % description.count;
                        }
                    }
                }
                
                Spacer()
                VStack {
                    NavigationLink(destination: Login().toolbar(.hidden)) {
                        Text("Zaloguj się")
                            .PrimaryColorButton()
                        
                        
                    }
                    NavigationLink(destination: Auth().toolbar(.hidden)) {
                        Text("Nie masz konta? Zarejestruj się")
                            .GrayColorButton()
                    }
                }.frame(width: 300)
                Spacer()
            }
        }
    }
}

struct Login: View {
    @State var login: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Spacer()
            TextField("Login", text: $login).standardField()
            PasswordField(text: "Hasło", password: $password)
            Spacer()
            Button(action: {}) {
                Text("Zaloguj się")
                    .PrimaryColorButton()
                    .shadow(radius: 10)
            }
        }.padding()
    }
}

struct Auth: View {
    @State var login: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var email: String = ""
    var body: some View {
        VStack {
            Spacer()
            TextField("Login", text: $login).standardField()
            TextField("Nazwa użytkownika", text: $username).standardField()
            PasswordField(text: "Hasło", password: $password)
            PasswordField(text: "Powtórz hasło", password: $password2)
            TextField("Email", text: $email).standardField()
            Spacer()
            Button(action: {}) {
                Text("Zarejestruj się")
                    .GrayColorButton(fontSize: 20)
                    
                    .shadow(radius: 10)
            }
            
        }.padding()
    }
}






#Preview {
    UserAuthView().environment(\.font, Font.custom("Inter-Regular_ExtraLight", size: 20))
//    Login();
}
