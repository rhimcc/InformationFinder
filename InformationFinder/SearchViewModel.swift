import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var isActive = false
    @Published var selectedCategories: [String: Bool] = [:] {
        didSet {
            applyFilters()
        }
    }
    @Published var filteredTopics: [Topic] = []
    var topics: [Topic] = []

    func applyFilters() {
        var filters: [String] = []
        print(selectedCategories)
        for (category, isSelected) in selectedCategories {
            if isSelected {
                filters.append(category)
            }
        }

        filteredTopics = topics.filter { filters.contains($0.category) }
    }
}
