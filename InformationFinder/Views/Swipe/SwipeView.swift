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
                modelContext.insert(Topic(topicName: "newtopic", topicDescription: "desc", topicInfo: "information", thumbsUp: false, beenSwiped: false, imageURL: "fhuiwjkv"))
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
