//
//  ThumbsUpView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI


struct ThumbsUpView: View {
    var thumbsedUp: [Topic]
    var body: some View {
        VStack {
            Text("Thumbs Up")
            Text("\(thumbsedUp.count)")
            ForEach(thumbsedUp, id: \.self) { topic in
                TopicCard(topic: topic)
            }
        }
    }
}

//#Preview {
//    ThumbsUpView()
//}
