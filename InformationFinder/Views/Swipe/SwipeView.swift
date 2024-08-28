//
//  SwipeView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var topics: [Topic]
    var body: some View {
        VStack {
            Button {
                let newTopic = Topic(topicName: "topic 1", topicDescription: "123", topicInfo: "detailed information", imageURL: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg", beenSwiped: false, thumbsUp: true)
                modelContext.insert(newTopic)
            } label : {
                Text("New")
            }
            Button {
                do {
                    try modelContext.delete(model: Topic.self)
                } catch {
                    print("Failed to delete all topics.")
                }
                
            } label : {
                Text("Delete")
            }
        }
    }
}
