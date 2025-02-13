//
//  Textfield.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//
import SwiftUI

struct standardFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 350, height: 50)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray1, lineWidth: 1))
                .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }
}

extension View {
    func standardField() -> some View {
        modifier(standardFieldModifier())
    }
}


struct PasswordField: View {
    @State var text: String;
    @Binding var password: String;
    @State var isSecured: Bool = true;
    var body: some View {
        HStack {
            if isSecured {
                SecureField(text, text: $password)

            }else {
                TextField(text, text: $password)
            }
            Button(action: {
                self.isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye").foregroundStyle(Color.black)
            }
        }.standardField()
    }
}
