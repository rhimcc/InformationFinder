//
//  SwipeView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var topicList: [Topic]


    @State private var swipeRight: Bool = false
     var cardWidth = 300
     var cardHeight = 500
    @State private var cardPosition: CGFloat = UIScreen.main.bounds.width / 2

    var body: some View {
        let topicViewModel: TopicViewModel = TopicViewModel(topicList: topicList)
        let unswipedTopics = topicViewModel.getUnswipedTopics()
        VStack {
            ZStack {
                ForEach(unswipedTopics) { topic in
                    TopicCard(topicViewModel: topicViewModel, cardIndex: topicViewModel.getIndexOfTopic(topic: topic) ?? 0, cardPosition: $cardPosition)
                        .frame(width: 300, height: 500)
                        .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        .position(x: cardPosition, y: 300)
                }
            }
            Button {
                modelContext.insert(Topic(topicName: "String", topicDescription: "String", topicInfo: "String", category: "String", imageURL: "String"))
            } label : {
                Text("Add")
            }
            Button {
                for topic in topicList {
                    modelContext.delete(topic)
                }
            } label : {
                Text("Delete all")
            }
             
        }
    }
    }

