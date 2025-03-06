//
//  GenerateTravelView.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/24/25.
//

import SwiftUI

struct GenerateTravelView: View {
    @State private var model: GenerateTravelModel = GenerateTravelModel(
        userId: 0,
        price: 500,
        destination: "Warszawa",
        from: "Kraków",
        members: 2,
        days: 2
    )
    
    @State private var travel: ReadyTravelModel = ReadyTravelModel(
        travelId: -1,
        imageUrl: "",
        days: 0,
        name: "",
        description: "",
        price: 0,
        from: "",
        destination: "",
        members: 0,
        likes: 0
    )
    
    @State private var userId: Int = UserDefaults.standard.string(forKey: "userId").flatMap { Int($0) } ?? 0
    @State private var isLoading: Int = 1
    @State private var errorMessage: String = ""
    @State private var fullscreen: Bool = false
    
    var body: some View {
        VStack {
            Text("Wygeneruj własną podróż")
            
            TextField("Skąd", text: $model.from)
                .standardField()
            
            TextField("Dokąd", text: $model.destination)
                .standardField()
            
            TextField("Ilość dni", value: $model.days, format: .number)
                .keyboardType(.decimalPad)
                .standardField()
            
            HStack {
                VStack(alignment: .leading) {
                    TextField("Budżet", value: $model.price, format: .number)
                        .keyboardType(.decimalPad)
                }
                Divider()
                TextField("Ilość osób", value: $model.members, format: .number)
            }
            .standardField()
            
            Text(errorMessage)
                .foregroundStyle(.red)
                .padding()
                .font(.system(size: 20))
            
            Button(action: {
                Task {
                    do {
                        isLoading = 1
                        await generateTravel()
                    } catch {
                        isLoading = -1
                        print("Błąd: \(error)")
                    }
                }
            }) {
                Text("Generuj")
            }
            .PrimaryColorButton(width: 130, fontSize: 18)
            .padding()
        }
        .padding(15)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray1, style: StrokeStyle(lineWidth: 1))
                .shadow(radius: 5)
        )
        .padding(20)
        .fullScreenCover(isPresented: $fullscreen) {
            SimpleNavbar(fullscreen: $fullscreen)
            
            if userId == 0 {
                UserAuthView()
            }
            else if isLoading == 1 {
                Spacer()
                VStack {
                    ProgressView()
                    Text("Generowanie podróży...")
                }
                Spacer()
            }
            else if isLoading == 0 && travel.travelId != -1 {
                ReadyTravelView(travel: travel)
            }
            else if isLoading == -1 {
                Spacer()
                VStack {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.red)
                        .font(.system(size: 32))
                        .padding(2)
                    
                    Text("Błąd!")
                    Text("Spróbuj ponownie później.")
                    
                    Button(action: { fullscreen.toggle() }) {
                        Text("OK")
                    }
                    .padding()
                }
                Spacer()
            }
        }.onDisappear(perform: {
            userId = UserDefaults.standard.string(forKey: "userId").flatMap { Int($0) } ?? 0
        })
    }
    
    func generateTravel() async {
        if model.destination.isEmpty || model.from.isEmpty || model.from.count < 3 || model.destination.count < 3 || model.days == 0 {
            errorMessage = "Uzupełnij wszystkie pola poprawnie!"
            return
        }
        
        fullscreen = true
        isLoading = 1
        
        do {
            travel = try await GenerateTravelService().GenerateTravel(model: model, userId: userId)
            
            if travel.travelId != -1 {
                DispatchQueue.main.async {
                    self.isLoading = 0
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = -1
            }
            print(error)
        }
    }
}

#Preview {
    GenerateTravelView()
        .font(.system(size: 18, weight: .thin))
}
