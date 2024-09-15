//
//  BrainSearchResults.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 29/8/2024.
//

import SwiftUI
import SwiftData

struct BrainSearchResults: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Query private var topics: [Topic]
        var filteredTopics: [Topic] {
        if searchViewModel.searchQuery.isEmpty {
            return Array(topics.filter {$0.beenSwiped}) // shows all topics which have been swiped on
          } else {
              return topics.filter { $0.topicName.localizedCaseInsensitiveContains(searchViewModel.searchQuery) && $0.beenSwiped} // shows all topics which have been swiped and match the search
          }
      }
    
    var body: some View {
        NavigationStack {
            if (filteredTopics.isEmpty) {
                VStack (alignment: .center){ // message shown if there is no match for the user's search
                    Image(systemName: "brain")
                        .font(.system(size: 70))
                        .padding(30)
                    Text("No swiped topics matches your search!")
                        .bold()
                        .font(.system(size: 25))
                        .padding(.bottom, 10)
                    Text("Search in home to see if it is an available topic, or try another search")
                        .bold()
                        .font(.system(size: 15))
                    
                }.foregroundStyle(.darkGreen)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 500)
                .position(x: UIScreen.main.bounds.width/2, y: 300)
            } else {
                ScrollView {
                    ForEach(Array(filteredTopics.enumerated()), id: \.element) { index, topic in //shows each of the search results which match the search query
                        NavigationLink {
                            TopicDetail(topic: topic)
                        } label : {
                            TopicRow(topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen) // alternates the colour of the rows for results
                                .padding([.top, .leading, .trailing], 20)
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
