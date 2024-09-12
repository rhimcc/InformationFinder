import SwiftUI
import Foundation
import SwiftData

struct ListBaseView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Query private var topics: [Topic]
    @State private var tabSelection = 0
    @State private var thumbsUp = true
    
    var body: some View {

            VStack {
       
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(searchViewModel.thumbsOptions.keys), id: \.self) { option in
                            Button {
                                searchViewModel.thumbsOptions[option]?.toggle()
                            } label: {
                                FilterBubble(filterName: option, isSelected: searchViewModel.thumbsOptions[option] ?? true)
                                
                            }
                        }
                        ForEach(Array(searchViewModel.readOptions.keys), id: \.self) { option in
                            Button {
                                searchViewModel.readOptions[option]?.toggle()
                            } label: {
                                FilterBubble(filterName: option, isSelected: searchViewModel.readOptions[option] ?? true)
                                
                            }
                        }
                    }.padding(.horizontal, 10)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(searchViewModel.selectedCategories.keys), id: \.self) { option in
                            Button {
                                searchViewModel.selectedCategories[option]?.toggle()
                            } label: {
                                FilterBubble(filterName: option, isSelected: searchViewModel.selectedCategories[option] ?? true)
                                
                            }
                        }
                    }.padding(.horizontal, 10)
                }
                HStack {
                    Spacer()
                    Text("(\(searchViewModel.filteredTopics.count) topics)")
                }.padding(.horizontal, 10)
                    .padding(.bottom, 0)
                    .padding(.top, 10)

                
                ScrollView {
                    ForEach(Array(searchViewModel.filteredTopics.enumerated()), id: \.element) { index, topic in
                        if (topic.beenSwiped) {
                            NavigationLink {
                                TopicDetail(topic: topic)
                            } label : {
                                TopicRow(topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen)
                                    .padding([.top, .leading, .trailing], 10)
                                
                            }
                        }
                    }
                }.padding(.top, 0)
            
            
            
        
        .onAppear {
            searchViewModel.topics = topics
            searchViewModel.applyFilters()
        }
        .padding(.top, 0)

    }
        
    }
}
