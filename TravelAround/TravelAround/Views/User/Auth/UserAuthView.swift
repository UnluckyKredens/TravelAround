//
//  UserAuthView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//

import SwiftUI

struct UserAuthView: View {
    let descriptions: [String] = [
        "Znajdź wycieczkę idealną dla siebie szybko i łatwo!",
        "Znajdź wymarzoną wycieczkę w kilka kliknięć!",
        "Twoja idealna wycieczka na wyciągnięcie ręki!",
        "Podróże dopasowane do ciebie",
        "Twoja wymarzona wycieczka czeka - odkryj ją z nami!",
        "Przygoda zaczyna się tutaj. Wybierz kierunek, a my dopasujemy wycieczkę do Twoich potrzeb."
    ]
    
    let pictures: [String] = ["plus", "minus", "rectangle.portrait.slash", "heart.slash.circle.fill", "drop.degreesign.slash", "rectangle.portrait.slash"]
    
    @State private var index: Int
    
    init() {
        _index = State(initialValue: Int.random(in: 0 ..< descriptions.count))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Image(systemName: pictures[index])
                        .padding()
                        .font(.system(size: 40))
                    Text(descriptions[index])
                        .multilineTextAlignment(.center)
                }
                .frame(height: 300)
                .padding()
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                        withAnimation(.easeIn(duration: 0.4)) {
                            index = (index + 1) % descriptions.count
                        }
                    }
                }
                Spacer()
                VStack {
                    NavigationLink(destination: Login().toolbar(.hidden)) {
                        Text("Zaloguj się")
                            .PrimaryColorButton()
                    }
                    NavigationLink(destination: Register().toolbar(.hidden)) {
                        Text("Nie masz konta? Zarejestruj się")
                            .GrayColorButton()
                    }
                }
                .frame(width: 300)
                Spacer()
            }
        }
    }
}

struct Login: View {
    @State private var user = UserModel(
        id: "",
        username: "",
        login: "",
        password: "",
        email: "",
        address: ""
    )
    @Environment(\.dismiss) private var dismiss
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Login", text: $user.login).standardField()
            PasswordField(text: "Hasło", password: $user.password)
            Spacer()
            Text(errorMessage)
            Button(action: {Task {
                await Login()
            }}) {
                Text("Zaloguj się")
                    .PrimaryColorButton()
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
    
    func Login() async {
        do {
            _ = try await UserService().LoginUser(user: user)
            dismiss()
        }catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct Register: View {
    @State private var user = UserModel(
        id: "",
        username: "",
        login: "",
        password: "",
        email: "",
        address: ""
    )
    @State private var password2: String = ""
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        VStack {
            Spacer()
            TextField("Login", text: $user.login).standardField()
            TextField("Nazwa użytkownika", text: $user.username).standardField()
            PasswordField(text: "Hasło", password: $user.password)
            PasswordField(text: "Powtórz hasło", password: $password2)
            TextField("Email", text: $user.email).standardField()
            TextField("Adres", text: $user.address).standardField()
            Spacer()
            Text(errorMessage).foregroundStyle(.red)
            Button(action: {
                Task {
                    await RegisterUser()
                }
            }) {
                Text("Zarejestruj się")
                    .GrayColorButton(fontSize: 20)
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
    
    func isEmailValid(text: String) -> Bool {
        let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return text.range(of: emailPattern, options: .regularExpression) != nil
    }
    
    func RegisterUser() async {
        errorMessage = ""
        
        if user.password != password2 {
            errorMessage += "Hasła są różne \n"
        }
        if !isEmailValid(text: user.email) {
            errorMessage += "Nieprawidłowy format email \n"
        }
        if user.address.isEmpty || user.login.isEmpty || user.username.isEmpty || user.password.isEmpty {
            errorMessage += "Uzupełnij wszystkie pola \n"
        }
        
        if errorMessage.isEmpty {
            do {
                _ = try await UserService().RegisterUser(user: user)
                dismiss()
            } catch {
                errorMessage += "\(error)"
            }
        }
    }
}

#Preview {
    UserAuthView()
        .environment(\.font, Font.custom("Inter-Regular_ExtraLight", size: 20))
}
