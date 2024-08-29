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
        ScrollView {
            ForEach(Array(thumbsedUp.enumerated()), id: \.element) { index, topic in
                NavigationLink {
                    TopicDetail(topic: topic)
                } label : {
                    TopicRow(topic: topic, colour: index % 2 == 0 ? .tan : .lightGreen)
                        .padding([.top, .leading, .trailing], 10)
                    
                }
            }
        }
    }
}


//#Preview {
//    ThumbsUpView()
//}
