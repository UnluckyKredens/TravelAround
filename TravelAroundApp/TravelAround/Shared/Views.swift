//
//  Views.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/5/25.
//

import SwiftUI

struct CleanNavBarView: View {
    @Binding var fullscreen: Bool
    var body: some View {
        HStack {
            Button(action: {
                self.fullscreen = false
            }) {
                Image(systemName: "arrow.left")
                    .frame(alignment:.leading)
                    .foregroundStyle(Color.gray)
                    .font(.title)
                    .padding([.leading, .bottom], 10.0)
            }
            Spacer()

            Spacer()
        }.padding()
            .frame(height: 45)
        Divider()
    }
}

struct HeartNavBarBoolView: View {
    @Binding var fullscreen: Bool
    @State private var liked: Bool = false
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    fullscreen.toggle()
                    print(fullscreen)
                }) {
                    Image(systemName: "arrow.left")
                        .frame(alignment:.leading)
                        .foregroundStyle(Color.gray)
                        .font(.title)
                        .padding([.leading, .bottom], 10.0)
                }
                Spacer()
                
                Spacer()
                if(liked) {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                        .modifier(ActionImageModifier())
                        .onTapGesture {liked = false}
                }else {
                    Image(systemName: "heart")
                        .modifier(ActionImageModifier())
                        .onTapGesture {liked = true}
                }
            }.padding()
            Divider()
        }
    }
}

