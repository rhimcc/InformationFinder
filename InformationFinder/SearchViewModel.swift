import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var isActive = false
    @Published var readOptions: [String: Bool] = ["Read": true, "Unread": true, "Reading": true]{
        didSet {
            applyFilters()
        }
    }
    @Published var thumbsOptions: [String: Bool] = ["Thumbs Up": true, "Thumbs Down": true] {
        didSet {
            applyFilters()
        }
    }
    
    @Published var selectedCategories: [String: Bool] = ["Humanity": true, "Computing": true, "History": true, "Nature": true, "Psychology": true, "Science": true] {
        didSet {
            applyFilters()
        }
    }
    
    @Published var filteredTopics: [Topic] = []
    var topics: [Topic] = []
    
    func applyFilters() {
        let selectedCategoryFilters = selectedCategories.filter { $0.value }.map { $0.key }
        let selectedReadFilters = readOptions.filter { $0.value }.map { $0.key }
        let selectedThumbsFilters = thumbsOptions.filter { $0.value }.map { $0.key }
        
        
        filteredTopics = topics.filter { topic in
            let categoryMatch = selectedCategoryFilters.contains(topic.category)

            let readStatusMatch: Bool
            if selectedReadFilters.contains("Read"), topic.readPercent == 100 {
                readStatusMatch = true
            } else if selectedReadFilters.contains("Unread"), topic.readPercent == 0 {
                readStatusMatch = true
            } else if selectedReadFilters.contains("Reading"), topic.readPercent > 0 && topic.readPercent < 100 {
                readStatusMatch = true
            } else {
                readStatusMatch = false
            }
            
            let thumbsStatusMatch: Bool
            if selectedThumbsFilters.contains("Thumbs Up"), topic.thumbsUp {
                thumbsStatusMatch = true
            } else if selectedThumbsFilters.contains("Thumbs Down"), !topic.thumbsUp {
                thumbsStatusMatch = true
            } else {
                thumbsStatusMatch = false
            }
            return categoryMatch && readStatusMatch && thumbsStatusMatch            
        }
    }
}
