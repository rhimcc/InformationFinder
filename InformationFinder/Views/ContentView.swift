//
//  ContentView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tabSelection = 1
    @Environment(\.modelContext) private var modelContext
    @Query private var topicList: [Topic]
    private var topics: Topics = Topics()
    var body: some View {
        TabView(selection: $tabSelection) {
            SearchBaseView(topics: topicList)
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            SwipeView()
                .tabItem{
                    Label("Swipe", systemImage: "menucard")
                    
                }
                .tag(1)
            
            BrainBankView(topics: topics)
                .tabItem {
                    Label("Brain Bank", systemImage: "brain")
                }
                .tag(2)
        }
        .onAppear {
            topics.loadTopicList(fromName: "Topics")
            if topicList.isEmpty {
                for topic in topics.topicList {
                    modelContext.insert(topic)
                }
            }
            for topic in topics.topicList {
                var topicIn: Bool = false
                for topicCheck in topicList {
                    if topicCheck.topicName == topic.topicName {
                        topicIn = true
                    }
                }
                if !topicIn {
                    modelContext.insert(topic)
                }
            }

        }
    }
}



#Preview {
    ContentView()
}
