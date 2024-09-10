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
            return Array(topics)
          } else {
              return topics.filter { $0.topicName.localizedCaseInsensitiveContains(searchViewModel.searchQuery) }
          }
      }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(Array(filteredTopics.enumerated()), id: \.element) { index, topic in
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

//#Preview {
//    BrainSearchResults()
//}
