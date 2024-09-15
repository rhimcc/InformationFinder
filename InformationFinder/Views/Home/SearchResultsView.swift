//
//  SearchResultsView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 29/8/2024.
//

import SwiftUI
import SwiftData

struct SearchResultsView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Query private var topics: [Topic]
        var filteredTopics: [Topic] {
        if searchViewModel.searchQuery.isEmpty {
            return Array(topics) // if there is no search query, all topics will be shown
          } else {
              return topics.filter { $0.topicName.localizedCaseInsensitiveContains(searchViewModel.searchQuery)} // filters the topics which match the search query
          }
      }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.tan // colours background
                    .edgesIgnoringSafeArea(.all)
                
                if (filteredTopics.isEmpty) { //if there are no topics which match the search
                    VStack (alignment: .center){
                        Image(systemName: "brain")
                            .font(.system(size: 70))
                            .padding(30)
                        Text("No topics matches your search!") // big text, shows the problem
                            .bold()
                            .font(.system(size: 25))
                            .padding(.bottom, 10)
                        Text("Unfortunately there is no topic matching to your search, try another search") // smaller text, to guide the user
                            .bold()
                            .font(.system(size: 15))
                        
                    }.foregroundStyle(.darkGreen)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 500)
                        .position(x: UIScreen.main.bounds.width/2, y: 300)
                } else {
                    ScrollView {
                        ForEach(Array(filteredTopics.enumerated()), id: \.element) { index, topic in // shows each of the topics as a topic row which links to a topic detail
                            NavigationLink {
                                TopicDetail(topic: topic)
                            } label : {
                                TopicRow(topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen)
                                    .padding([.top, .leading, .trailing], 20)
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
}

//#Preview {
//    BrainSearchResults()
//}
