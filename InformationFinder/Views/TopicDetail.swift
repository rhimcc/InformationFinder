//
//  TopicDetail.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 29/8/2024.
//

import SwiftUI

struct TopicDetail: View {
    var topic: Topic
    var body: some View {
        VStack {
            Text(topic.topicName)
        }
    }
}

//#Preview {
//    TopicDetail()
//}
