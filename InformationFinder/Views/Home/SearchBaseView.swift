//
//  SearchBaseView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI

struct SearchBaseView: View {
    var topics: [Topic]
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            SearchView(searchViewModel: searchViewModel) // always shows the search view (just search bar)

            if (searchViewModel.isActive) {
                SearchResultsView(searchViewModel: searchViewModel) // shows the results of the search if its active

            } else {
                SuggestedTopicsView() // shows the suggested topics if the search isnt active
            }
        }
    
    }
}

//#Preview {
//    SearchBaseView()
//}
