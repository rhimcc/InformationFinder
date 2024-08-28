//
//  SuggestedTopicsView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI

struct SuggestedTopicsView: View {
    var body: some View {
        VStack {
            Text("New topics")
            TopicCard(topic: Topic(topicName: "Black Hole", isFavourited: false, imageURL: "https://upload.wikimedia.org/wikipedia/commons/4/4f/Black_hole_-_Messier_87_crop_max_res.jpg"))
                .frame(width: 180, height: 240)
            
        }
    }
}

#Preview {
    SuggestedTopicsView()
}
