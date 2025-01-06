//
//  UserAuthView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/4/25.
//

import SwiftUI

struct UserAuthView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var register: Bool = false
    @State var regulations: Bool = false
    private var userService: UserService = UserService()
    var body: some View {
        Image("Logo").resizable().frame(width: 250, height: 80, alignment: .top).padding(.leading, 10.0)

        if(!register) {
            VStack {
                Text("Witamy ponownie!").font(.title2)
                    .padding()
                TextField("Login", text: $username)
                    .textFieldStyle(CustomTextFieldStyle())
                SecureField("Hasło", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.vertical)
                Button(action: {
                    Task {
                        print("aaa")
                        await Login()
                    }
                    
                }) {
                    Text("Zaloguj się")
                }.buttonStyle(BlueButtonStyle())
                    .padding(.vertical)
                Button("Zarejestruj się") {
                    self.register = !register
                }.buttonStyle(BlueButtonStyle())
                
                
            }.padding()
        }else {
            VStack {
                Text("Stwórz konto w 5 minut").font(.title2)
                    .padding()
                TextField("Login", text: $username)
                    .textFieldStyle(CustomTextFieldStyle())
                SecureField("Hasło", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.vertical)
                TextField("Email", text: $username)
                    .textFieldStyle(CustomTextFieldStyle())
                TextField("Kraj zamieszkania", text: $username)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.top)
                Toggle(isOn: $regulations) {Text("Zapoznałem/am się z regulaminem")}.padding()
                Button("Zarejestruj się") {
                    print("Logged in")
                }.buttonStyle(BlueButtonStyle())
                    .padding(.vertical)
                Button("Zaloguj się") {
                    self.register = !register
                }.buttonStyle(BlueButtonStyle())
                
                
            }.padding()
        }
        Spacer()
    }
    
    func Login() async {
        do {
            let token = try await userService.Login(username: username, password: password)
            print("token wyjściowy \(token)")
        }
        catch {
            print("error \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    UserAuthView()
}
