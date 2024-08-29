//
//  SwipeView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    @Query var topics: [Topic]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        VStack {
            Button {
                let newTopic = Topic(topicName: "topic 1", topicDescription: "123", topicInfo: "detailed information", category: "Science", imageURL: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg", beenSwiped: false, thumbsUp: true)
                modelContext.insert(newTopic)
            } label : {
                Text("New")
            }
            Button {

                
            } label : {
                Text("Delete")
            }
        }
    }
}
