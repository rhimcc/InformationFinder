import SwiftUI
import SwiftData

struct BrainBankView: View {
    @Query var topics: [Topic]
//    var topics: Topics
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                
                BrainSearchView(searchViewModel: searchViewModel)
                
                if (searchViewModel.isActive) {
                    BrainSearchResults(searchViewModel: searchViewModel)
                    
                } else {
                    ListBaseView(searchViewModel: searchViewModel)
                }
            }.background(.tan)
        }
    
    }
}

//#Preview {
//    SearchBaseView()
//}
