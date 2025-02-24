//
//  SearchBar.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/1/25.
//

import SwiftUI

struct SearchBar: View {
    @State var search: String = "";
    @State var fullscreen: Bool = false;
    var body: some View {
        HStack {
            TextField("Gdzie chcesz się wybrać?", text: $search ).onSubmit {
                fullscreen.toggle()
            }
            Image(systemName: "magnifyingglass").onTapGesture {
                Task {
                    fullscreen.toggle();
                }
            }.fullScreenCover(isPresented: $fullscreen) {
                SimpleNavbar(fullscreen: $fullscreen)
                TravelSearchResult(searchedText: search)
            }
        }
        .padding()
        .frame(width: 350, height: 50)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray1, lineWidth: 1))
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
            
    }
}

#Preview {
    SearchBar()
}
