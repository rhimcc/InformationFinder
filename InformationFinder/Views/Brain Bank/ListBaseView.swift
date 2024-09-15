import SwiftUI
import Foundation
import SwiftData

struct ListBaseView: View {
//    @ObservedObject var searchViewModel: SearchViewModel
    @StateObject var filterViewModel: FilterViewModel = FilterViewModel()
    @Query private var topics: [Topic]
    @State private var tabSelection = 0
    @State private var thumbsUp = true
    @State private var falseOption: Bool = false
    @State private var falseCounter: Int = 0
    @State private var errorMessage: String? = nil
    @State private var selectedCount: Int = 0
//    @State private var allSelected: Bool = true
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button {
                       setAllTrue()
                    } label: {
                        FilterBubble(filterName: "ALL", isSelected: filterViewModel.checkAllSelected())
                    }
                    ForEach(Array(filterViewModel.thumbsOptions.keys), id: \.self) { option in
                        Button {
                            errorMessage = filterViewModel.toggleOption(for: &filterViewModel.thumbsOptions, option: option)
                        } label: {
                            FilterBubble(filterName: option, isSelected: filterViewModel.thumbsOptions[option] ?? true)
                        }
                    }
                    
                    ForEach(Array(filterViewModel.readOptions.keys), id: \.self) { option in
                        Button {
                            errorMessage = filterViewModel.toggleOption(for: &filterViewModel.readOptions, option: option)
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
                            errorMessage = filterViewModel.toggleOption(for: &filterViewModel.selectedCategories, option: option)
                        } label: {
                            FilterBubble(filterName: option, isSelected: filterViewModel.selectedCategories[option] ?? true)
                        }
                    }
                }
            }
            
            
            if let errorMessage = errorMessage {
                Text("* You must have at least one \(errorMessage) selected")
                    .font(.system(size: 15))
                    .foregroundStyle(.red)
                    .frame(alignment: .leading)
            }
            
            HStack {
                Spacer()
                Text("(\(filterViewModel.filteredTopics.count) topics)")
            }.padding(.horizontal, 10)
                .padding(.bottom, 0)
                .padding(.top, 10)
            
            if (filterViewModel.filteredTopics.isEmpty) {
                ErrorView(text: "The selected filters have no matches", tip: "Try different filters")
            }
            
            ScrollView {
                ForEach(Array(filterViewModel.filteredTopics.enumerated()), id: \.element) { index, topic in
                    if (topic.beenSwiped) {
                        NavigationLink {
                            TopicDetail(topic: topic)
                        } label : {
                            TopicRow(filterViewModel: filterViewModel, topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen)
                                .padding([.top, .leading, .trailing], 10)
                            
                        }
                    }
                }
            }.padding(.top, 0)
        }.padding(.horizontal, 5)
        .onAppear {
            filterViewModel.topics = topics
            filterViewModel.applyFilters()
        }
    }
    
    func setAllTrue() {
        for option in filterViewModel.readOptions.keys {
            filterViewModel.readOptions[option] = true
        }
        for option in filterViewModel.thumbsOptions.keys {
            filterViewModel.thumbsOptions[option] = true
        }
        for option in filterViewModel.selectedCategories.keys {
            filterViewModel.selectedCategories[option] = true
        }
    }
}
                
                
                
                
               
                

