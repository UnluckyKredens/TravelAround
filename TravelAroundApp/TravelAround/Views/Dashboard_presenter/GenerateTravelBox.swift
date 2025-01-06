import SwiftUI

struct GenerateTravelBox: View {
    @State var from: String = ""
    @State var to: String = ""
    @State var budget: String = ""
    @State var members: String = ""
    @State var days: String = ""
    @State private var errorMessage: String = ""
    @ObservedObject private var chatGPTService = ChatGPTService()
    @State var fullscreen: Bool = false;
    @State var res: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Stwórz swój plan podróży")
                .font(.headline)
                .padding(.bottom, 10)
            
            // From TextField
            TextField("Skąd", text: $from)
                .textFieldStyle(CustomTextFieldStyle())
            
            // To TextField
            TextField("Dokąd", text: $to)
                .textFieldStyle(CustomTextFieldStyle())
            
            // Budget TextField
            TextField("Budżet", text: $budget)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("Ilość dni", text: $days)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("Ilość osób", text: $members)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button(action: {
                errorMessage = ""
                if from.isEmpty || to.isEmpty || budget.isEmpty {
                    errorMessage = "Uzupełnij wszystkie pola"
                } else {
                    chatGPTService.fetchBestTravelOption(from: from, to: to, budget: budget, days: days, members: members)
                    fullscreen = true;
                }
            })
            {
                Text("Generuj")
            }
            .buttonStyle(BlueButtonStyle())
            .fullScreenCover(isPresented: $fullscreen) {
                HeartNavBarBoolView(fullscreen: $fullscreen)

                    
                    ScrollView {
                        if chatGPTService.responseText.isEmpty {
                            LoadingView()
                        }
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        if  !chatGPTService.responseText.isEmpty {
                            GPTGeneratedTravel(from: from, to: to, budget: budget, members: members, days: days, response: chatGPTService.responseText)
                        }
                    }
                }
                }
            
            Spacer()
        }
    }

#Preview {
    GenerateTravelBox()
}
