import SwiftUI

struct ReadyTravelsList: View {
    @State private var ReadyTravels: [ReadyTravelModel] = []
    
    @State var selectedTravel: ReadyTravelModel? = nil
    @State var isLoading: Int = 1
    private var travelService = TravelService()
    
    var body: some View {
        HStack {
            if isLoading == 1 {
                ProgressView("Loading...")
            }
            else if isLoading == -1 {
                VStack {
                    Image(systemName: "x.circle").foregroundStyle(.red).font(.system(size: 32)).padding(2)
                    Text("Coś poszło nie tak").font(.system(size: 18, weight: .light))
                }.frame(height: 180)
            }else if isLoading == -2 {
                VStack {
                    Image(systemName: "x.circle").foregroundStyle(.red).font(.system(size: 32)).padding(2)
                    Text("Lista jest pusta").font(.system(size: 18, weight: .light))
                }
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(ReadyTravels) { travel in
                            Card(travel: travel, selectedTravel: selectedTravel)
                        }.frame(height: 230, alignment: .center)
                    }
                }
            }
        }.task {
            await DownloadTopTravels()
        }.padding()

    }
    
    
    
    func DownloadTopTravels() async {
        do {
            let travels = try await travelService.DownloadTopTravels()
            if(travels.isEmpty) {
                self.isLoading = -2
            }else {
                self.ReadyTravels = travels
                 self.isLoading = 0
            }
        } catch {
            self.isLoading = -1
        }
    }
    
}

#Preview {
    ReadyTravelsList()
}
