//
//  Styles.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/4/25.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .background(Color.white)
            .foregroundColor(.black)
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal)
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct ActionImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        //            .frame(maxWidth: .infinity)
            .foregroundColor(.gray)
            .font(.title)
            .padding([.leading, .trailing], 15.0)
            .padding([.bottom], 10.0)
    }
}
