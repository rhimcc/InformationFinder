//
//  ThumbsDownView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct ThumbsDownView: View {
    var thumbsedDown: [Topic]
    var body: some View {
        ScrollView {
            ForEach(Array(thumbsedDown.enumerated()), id: \.element) { index, topic in
                if (!topic.thumbsUp) {
                    NavigationLink {
                        TopicDetail(topic: topic)
                    } label : {
                        TopicRow(topic: topic, colour: index % 2 == 0 ? .midGreen : .lightGreen)
                            .frame(height: 120)
                            .padding([.top, .leading, .trailing], 20)
                        
                    }
                }
               
            }
        }
    }
}

//#Preview {
//    ThumbsDownView()
//}
