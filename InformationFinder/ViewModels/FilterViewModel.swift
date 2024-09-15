//
//  FilterViewModel.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 15/9/2024.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var readOptions: [String: Bool] = ["Read": false, "Unread": false, "Reading": false]{
        didSet {
            applyFilters()
        }
    }
    @Published var thumbsOptions: [String: Bool] = ["Thumbs Up": false, "Thumbs Down": false] {
        didSet {
            applyFilters()

        }
    }
    
    @Published var selectedCategories: [String: Bool] = ["Humanity": false, "Computing": false, "History": false, "Nature": false, "Science": false, "Art": false] {
        didSet {
            applyFilters()
        }
    }
    
    @Published var filteredTopics: [Topic] = []
    var topics: [Topic] = []
    var allSelected = true
    
    func applyFilters() {
        let selectedCategoryFilters = selectedCategories.filter { $0.value }.map { $0.key }
        let selectedReadFilters = readOptions.filter { $0.value }.map { $0.key }
        let selectedThumbsFilters = thumbsOptions.filter { $0.value }.map { $0.key }
        
        // Show all topics if no filters are selected
        if selectedCategoryFilters.isEmpty && selectedReadFilters.isEmpty && selectedThumbsFilters.isEmpty {
            filteredTopics = topics
            return
        }
        
        
        filteredTopics = topics.filter { topic in
            let swipeStatusMatch: Bool
            if topic.beenSwiped {
                swipeStatusMatch = true
            } else {
                swipeStatusMatch = false
            }
            
            let categoryMatch: Bool
            if selectedCategoryFilters.isEmpty {
                categoryMatch = true
            } else {
                categoryMatch = selectedCategoryFilters.contains(topic.category)
            }
            
            let readStatusMatch: Bool
            if selectedReadFilters.isEmpty {
                    readStatusMatch = true
            } else {
                if selectedReadFilters.contains("Read"), topic.readPercent == 100 {
                    readStatusMatch = true
                } else if selectedReadFilters.contains("Unread"), topic.readPercent == 0 {
                    readStatusMatch = true
                } else if selectedReadFilters.contains("Reading"), topic.readPercent > 0 && topic.readPercent < 100 {
                    readStatusMatch = true
                } else {
                    readStatusMatch = false
                }
            }
            
            let thumbsStatusMatch: Bool
            if selectedThumbsFilters.isEmpty {
                thumbsStatusMatch = true
            } else {
                if selectedThumbsFilters.contains("Thumbs Up"), topic.thumbsUp {
                    thumbsStatusMatch = true
                } else if selectedThumbsFilters.contains("Thumbs Down"), !topic.thumbsUp {
                    thumbsStatusMatch = true
                } else {
                    thumbsStatusMatch = false
                }
            }

            return (categoryMatch && readStatusMatch && thumbsStatusMatch) && swipeStatusMatch
        }
        
    }
    
    func checkNoneSelected() -> Bool {
        if readOptions.values.contains(true) || thumbsOptions.values.contains(true) || selectedCategories.values.contains(true) {
            return false
        }
        return true
    }
}
