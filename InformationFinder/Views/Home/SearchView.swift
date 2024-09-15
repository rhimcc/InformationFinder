//
//  SearchView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchQuery: String  = ""
    @ObservedObject var searchViewModel : SearchViewModel
    var body: some View {
        NavigationStack {
//            ZStack {
//                Color.tan
//                    .edgesIgnoringSafeArea(.all)
//            }
            
            VStack {
            }
            .searchable(text: $searchViewModel.searchQuery, isPresented: $searchViewModel.isActive, prompt: "Search...")
            
            
        }
    }
    
}

//#Preview {
//    SearchView()
//}
