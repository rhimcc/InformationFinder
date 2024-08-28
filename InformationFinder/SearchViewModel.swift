//
//  SearchViewModel.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var isActive = false
}
