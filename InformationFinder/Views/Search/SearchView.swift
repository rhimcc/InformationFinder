//
//  SearchView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Query private var topics: [Topic]
    @State private var searchQuery: String  = ""
    @ObservedObject var searchViewModel : SearchViewModel
    var body: some View {
        NavigationStack {
            
            VStack {
            }
            .searchable(text: $searchQuery, prompt: "Search...")
            
            
        }
    }
    
}

//#Preview {
//    SearchView()
//}
