import SwiftUI

struct GenerateTravelBox: View {
    @State var from = ""
    @State var to = ""
    @State var budget = ""
    @State private var errorMessage: String = ""
    @ObservedObject private var chatGPTService = ChatGPTService()
    @State var fullscreen: Bool = false;
    @State var res: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Find the Best Travel Option")
                .font(.headline)
                .padding(.bottom, 10)
            
            // From TextField
            TextField("From", text: $from)
                .textFieldStyle(CustomTextFieldStyle())
            
            // To TextField
            TextField("To", text: $to)
                .textFieldStyle(CustomTextFieldStyle())
            
            // Budget TextField
            TextField("Max. Budget", text: $budget)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button(action: {
                errorMessage = ""
                if from.isEmpty || to.isEmpty || budget.isEmpty {
                    errorMessage = "Please fill in all fields."
                } else {
                    chatGPTService.fetchBestTravelOption(from: from, to: to, budget: budget)
                    fullscreen = true;
                }
            }) {
                Text("Generate")
                    .frame(width: 150, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.fullScreenCover(isPresented: $fullscreen) {
                VStack {
                    HStack {
                        Button(action: {
                            fullscreen = false
                        }) {
                            Image(systemName: "arrow.left")
                                .frame(alignment:.leading)
                                .foregroundStyle(Color.gray)
                                .font(.title)
                                .padding([.leading, .bottom], 10.0)
                        }
                        Spacer()
                        Text("Wycieczka z \(from) do \(to) w budgecie \(budget)").font(.headline)

                        Spacer()
                        Image(systemName: "heart")
                            .foregroundStyle(Color.gray)
                            .font(.title)
                            .padding([.leading, .bottom], 10.0)
                    }.padding()
                    Divider()

                    
                    ScrollView {
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        if !chatGPTService.responseText.isEmpty {
                            Text(chatGPTService.responseText)
                                .multilineTextAlignment(.center)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                        }
                    }
                }
                }
            
            Spacer()
        }
        .padding()
    }
}

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


#Preview {
    GenerateTravelBox()
}
