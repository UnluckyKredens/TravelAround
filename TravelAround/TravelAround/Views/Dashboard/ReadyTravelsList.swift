import SwiftUI

struct ReadyTravelsList: View {
    @State private var ReadyTravels: [ReadyTravelModel] = [ReadyTravelModel(travelId: 1, imageUrl: "", name: "aa", description: "aaa", price: 200)]
    
    @State var selectedTravel: ReadyTravelModel? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(ReadyTravels) { travel in
                    Card(travel: travel, selectedTravel: selectedTravel)
                }.frame(height: 230, alignment: .center)
            }
        }
    }
}

#Preview {
    ReadyTravelsList()
}
