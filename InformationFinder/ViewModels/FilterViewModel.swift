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
            applyFilters() //applies the filters to the brain bank list when any of the above options are toggled
        }
    }
    @Published var thumbsOptions: [String: Bool] = ["Thumbs Up": false, "Thumbs Down": false] {
        didSet {
            applyFilters() //applies the filters to the brain bank list when any of the above options are toggled
        }
    }
    
    @Published var selectedCategories: [String: Bool] = ["Humanity": false, "Computing": false, "History": false, "Nature": false, "Science": false, "Art": false] {
        didSet {
            applyFilters() //applies the filters to the brain bank list when any of the above options are toggled
        }
    }
    
    @Published var filteredTopics: [Topic] = []
    var topics: [Topic] = []
    var allSelected = true
    
    func applyFilters() {
        let selectedCategoryFilters = selectedCategories.filter { $0.value }.map { $0.key } // gets all of the selected filters from the category section
        let selectedReadFilters = readOptions.filter { $0.value }.map { $0.key } // gets all of the selected filters from the read section
        let selectedThumbsFilters = thumbsOptions.filter { $0.value }.map { $0.key } // gets all of the selected filters from the thumbs section
        
        // Show all topics that have been swiped if no filters are selected
        if selectedCategoryFilters.isEmpty && selectedReadFilters.isEmpty && selectedThumbsFilters.isEmpty {
            filteredTopics = topics.filter {$0.beenSwiped}
            return
        }
        
        
        filteredTopics = topics.filter { topic in
            let swipeStatusMatch: Bool
            swipeStatusMatch = topic.beenSwiped // filtered topics shows only topics which have been swiped
            
            let categoryMatch: Bool
            if selectedCategoryFilters.isEmpty {
                categoryMatch = true //if there is no category filter selected, it will show all categories
            } else {
                categoryMatch = selectedCategoryFilters.contains(topic.category)
            }
            
            let readStatusMatch: Bool
            if selectedReadFilters.isEmpty { //if there is no read filter selected, it will show all read options
                    readStatusMatch = true
            } else {
                if selectedReadFilters.contains("Read"), topic.readPercent == 100 { //if read filter is active and the topic has been read, it'll match
                    readStatusMatch = true
                } else if selectedReadFilters.contains("Unread"), topic.readPercent == 0 { //if unread filter is active and the topic has not been read, it'll match
                    readStatusMatch = true
                } else if selectedReadFilters.contains("Reading"), topic.readPercent > 0 && topic.readPercent < 100 { //if reading filter is active and the topic has been read some, but not 100%, it'll match
                    readStatusMatch = true
                } else {
                    readStatusMatch = false
                }
            }
            
            let thumbsStatusMatch: Bool
            if selectedThumbsFilters.isEmpty { //if there is no thumb filter selected, it will show all thumb options
                thumbsStatusMatch = true
            } else {
                if selectedThumbsFilters.contains("Thumbs Up"), topic.thumbsUp { // if the thumbs up filter is active and the topic has been thumbsed up, it'll match
                    thumbsStatusMatch = true
                } else if selectedThumbsFilters.contains("Thumbs Down"), !topic.thumbsUp {  // if the thumbs down filter is active and the topic has been thumbsed down, it'll match
                    thumbsStatusMatch = true
                } else {
                    thumbsStatusMatch = false
                }
            }

            return (categoryMatch && readStatusMatch && thumbsStatusMatch) && swipeStatusMatch //will add the topic to the filtered topics list if the category, read status, thumb status has been matched with the active filters, and if the topic has been swiped.
        }
        
    }
    
    func checkNoneSelected() -> Bool {
        if readOptions.values.contains(true) || thumbsOptions.values.contains(true) || selectedCategories.values.contains(true) { //if any of the filters are active
            return false //returns false to the fact that none are selected
        }
        return true // returns true that no filters have been selected
    }
}
