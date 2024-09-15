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
            TabView(selection: $tabSelection) { // tab bar at the bottom which controls the main views
                SearchBaseView(topics: topicList)
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                            .padding(.top, 10)

                    }
                    .tag(0)
                
                SwipeView()
                    .tabItem{
                        Label("Swipe", systemImage: "menucard")
                            .padding(.top, 10)
                    }
                    .tag(1)
                
                BrainBankView()
                    .tabItem {
                        Label("Brain Bank", systemImage: "brain")
                            .padding(.top, 10)
                    }
                    .tag(2)
            }
            .background(.darkTan)
            .tint(.darkGreen)
            .onAppear {
                
                topics.loadTopicList(fromName: "Topics") // loads the topic list
                if topicList.isEmpty {
                    for topic in topics.topicList { // if there are no topics in the model context/container, it will insert all of the topics from the loaded topic list
                        modelContext.insert(topic)
                    }
                }
                for topic in topics.topicList {
                    var topicIn: Bool = false
                    for topicCheck in topicList {
                        if topicCheck.topicName == topic.topicName { // checks if a topic with the topic name already exists in the list
                            topicIn = true
                        }
                    }
                    if !topicIn {
                        modelContext.insert(topic) // will insert any unique topics, simplifying the process of adding topics to the JSON file
                    }
                }
                
            }
        }
    }




#Preview {
    ContentView()
}

