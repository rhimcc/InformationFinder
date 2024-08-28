//
//  ThumbsDownView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI

struct ThumbsDownView: View {
    var thumbsedDown: [Topic]
    var body: some View {
        VStack {
            Text("Thumbs Down:")
            Text("\(thumbsedDown.count)")
            ForEach(thumbsedDown, id: \.self) { topic in
                TopicCard(topic: topic)
            }
        }
    }
}

//#Preview {
//    ThumbsDownView()
//}
