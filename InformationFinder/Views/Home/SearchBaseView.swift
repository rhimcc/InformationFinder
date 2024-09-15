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
            SearchView(searchViewModel: searchViewModel)

            if (searchViewModel.isActive) {
                SearchResultsView(searchViewModel: searchViewModel)

            } else {
                SuggestedTopicsView()
            }
        }
    
    }
}

//#Preview {
//    SearchBaseView()
//}
