import SwiftUI
import SwiftData

struct BrainBankView: View {
    @Query var topics: [Topic]
//    var topics: Topics
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                BrainSearchView(searchViewModel: searchViewModel) // always shown, just the search bar
                
                if (searchViewModel.isActive) {
                    BrainSearchResults(searchViewModel: searchViewModel) // shows search results, when the user has clicked the search bar
                    
                } else {
                    ListBaseView() // otherwise shows the list with the filter bubbles
                }
            }.background(.tan)
        }
    
    }
}

//#Preview {
//    SearchBaseView()
//}
