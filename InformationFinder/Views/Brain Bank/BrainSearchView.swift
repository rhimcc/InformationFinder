//
//  Brain.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import SwiftUI
import SwiftData

struct BrainSearchView: View {
    @ObservedObject var searchViewModel : SearchViewModel
    var body: some View {
       
        EmptyView()
            .searchable(text: $searchViewModel.searchQuery, isPresented: $searchViewModel.isActive, prompt: "Search...")
    }

}

//#Preview {
//    BrainBankView()
//}
