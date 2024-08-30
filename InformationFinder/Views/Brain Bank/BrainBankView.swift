import SwiftUI

struct BrainBankView: View {
    var topics: Topics
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            BrainSearchView(searchViewModel: searchViewModel)

            if (searchViewModel.isActive) {
                BrainSearchResults(searchViewModel: searchViewModel)

            } else {
                ListBaseView()
            }
        }
    
    }
}

//#Preview {
//    SearchBaseView()
//}
