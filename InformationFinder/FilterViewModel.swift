//
//  FilterViewModel.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 15/9/2024.
//

import Foundation

class FilterViewModel: ObservableObject {
    
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
    var allSelected = true
    
    func applyFilters() {
        let selectedCategoryFilters = selectedCategories.filter { $0.value }.map { $0.key }
        let selectedReadFilters = readOptions.filter { $0.value }.map { $0.key }
        let selectedThumbsFilters = thumbsOptions.filter { $0.value }.map { $0.key }
        
        
        filteredTopics = topics.filter { topic in
            let swipeStatusMatch: Bool
            if topic.beenSwiped {
                swipeStatusMatch = true
            } else {
                swipeStatusMatch = false
            }
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
            return categoryMatch && readStatusMatch && thumbsStatusMatch && swipeStatusMatch
        }
    }
    
    func toggleOption(for options: inout [String: Bool], option: String) -> String? {
        let selectedCount = options.values.filter { $0 }.count
        
        if let isSelected = options[option], isSelected {
            if selectedCount == 1 {
                switch options {
                case readOptions:
                    return "read option"
                    
                case selectedCategories:
                    return "category"
                    
                case thumbsOptions:
                    return "thumb option"
                
                default:
                    return nil
                }
            } else {
                options[option]?.toggle()
                return nil
            }
        } else {
            options[option]?.toggle()
            return nil
        }
    }
    
    func checkAllSelected() -> Bool {
        if readOptions.values.contains(false) || thumbsOptions.values.contains(false) || selectedCategories.values.contains(false) {
            return false
        }
        return true
    }
}
