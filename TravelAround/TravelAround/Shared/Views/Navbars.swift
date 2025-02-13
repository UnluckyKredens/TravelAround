//
//  SimpleNavbar.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/2/25.
//

import SwiftUI

struct SimpleNavbar: View {
    @Binding var fullscreen: Bool;
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .padding(.leading, 15.0)
                .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                .onTapGesture {
                self.fullscreen.toggle()
            }
            Spacer()
            Image("Logo").resizable().frame(width: 210, height: 64)
            Spacer()
            Spacer()
        }.frame(height: 64)
    }
}

struct TravelNavbar: View {
    @Binding var selectedTravel: ReadyTravelModel?;
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .padding(.leading, 15.0)
                .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                .onTapGesture {
                    selectedTravel = nil
            }
            Spacer()
            Image("Logo").resizable().frame(width: 210, height: 64)
            Spacer()
            Image(systemName: "heart")
                .padding(.trailing, 15.0)
                .font(Font.custom("Inter-Regular_ExtraLight", size: 24))
                .onTapGesture {
                    selectedTravel = nil
            }
        }.frame(height: 64)
    }
}

#Preview {
    @Previewable @State var fullscreenV: Bool = true;
    SimpleNavbar(fullscreen: $fullscreenV)
}
