import SwiftUI
import Foundation
import SwiftData

struct ListBaseView: View {
    @StateObject var filterViewModel: FilterViewModel = FilterViewModel()
    @Query private var topics: [Topic]
    @State private var thumbsUp = true
    @State private var falseOption: Bool = false
    @State private var falseCounter: Int = 0
    @State private var errorMessage: String? = nil
    @State private var selectedCount: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button { // button allows the user to deselect all of the filters to show all of the topics
                       setAllFalse()
                    } label: {
                        FilterBubble(filterName: "ALL", isSelected: filterViewModel.checkNoneSelected())
                    }
                    ForEach(Array(filterViewModel.thumbsOptions.keys), id: \.self) { option in
                        Button {
                            filterViewModel.thumbsOptions[option]?.toggle() // toggles the selected thumbs option
                        } label: {
                            FilterBubble(filterName: option, isSelected: filterViewModel.thumbsOptions[option] ?? true)
                        }
                    }
                    
                    ForEach(Array(filterViewModel.readOptions.keys), id: \.self) { option in
                        Button {
                            filterViewModel.readOptions[option]?.toggle() // toggles the selected read option
                        } label: {
                            FilterBubble(filterName: option, isSelected: filterViewModel.readOptions[option] ?? true)
                        }
                    }
                }
            }
        
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(filterViewModel.selectedCategories.keys), id: \.self) { option in
                        Button {
                            filterViewModel.selectedCategories[option]?.toggle() // toggles the selected category
                        } label: {
                            FilterBubble(filterName: option, isSelected: filterViewModel.selectedCategories[option] ?? true)
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                Text("(\(filterViewModel.filteredTopics.count) topics)") // shows the amount of topics, adjusting for filters
            }.padding(.horizontal, 10)
                .padding(.bottom, 0)
                .padding(.top, 10)
            
            if (filterViewModel.filteredTopics.isEmpty) {
                if (filterViewModel.checkNoneSelected()) { // if there are no filters active, and there are no topics to be shown
                    ErrorView(text: "You have not swiped on any topics", tip: "Go to \"Swipe\" and get swiping!")
                } else {
                    //if there are filters active, but theres no topics to be shown, there are no matches for topics with the selected filters
                    ErrorView(text: "The selected filters have no matches", tip: "Try different filters")
                }
            }
            
            ScrollView {
                ForEach(Array(filterViewModel.filteredTopics.enumerated()), id: \.element) { index, topic in // shows each of the topics which match the selected filters
                    NavigationLink {
                        TopicDetail(topic: topic)
                    } label : {
                        TopicRow(filterViewModel: filterViewModel, topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen)
                            .padding([.top, .leading, .trailing], 10)
                    }
                }
            }.padding(.top, 0)
        }.padding(.horizontal, 5)
        .onAppear {
            filterViewModel.topics = topics
            filterViewModel.applyFilters() // applies the filters
        }
    }
    
    func setAllFalse() { // sets all filters to false
        for option in filterViewModel.readOptions.keys {
            filterViewModel.readOptions[option] = false
        }
        for option in filterViewModel.thumbsOptions.keys {
            filterViewModel.thumbsOptions[option] = false
        }
        for option in filterViewModel.selectedCategories.keys {
            filterViewModel.selectedCategories[option] = false
        }
    }
}
                
                
                
                
               
                

