//
//  Text.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//
import SwiftUI

struct PrimaryColorButtonModifier: ViewModifier {
    @State var width: CGFloat;
    @State var fontSize: CGFloat;
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .padding()
            .frame(width: width)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
    }
}

struct GrayColorButtonModifier: ViewModifier {
    @State var width: CGFloat;
    @State var fontSize: CGFloat;
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .padding()
            .frame(width: width)
            .background(Color.gray)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
    }
}

extension View {
    func PrimaryColorButton(width: CGFloat = 250, fontSize: CGFloat = 20) -> some View {
        modifier(PrimaryColorButtonModifier(width: width,fontSize: fontSize))
    }
    
    func GrayColorButton(width: CGFloat = 250, fontSize: CGFloat = 15) -> some View {
        modifier(GrayColorButtonModifier(width: width,fontSize: fontSize))
    }
}
