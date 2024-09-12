//
//  SuggestedTopicsView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SuggestedTopicsView: View {
    @Query private var topics: [Topic]
    var continueReading: [Topic] {
        var continueReading: [Topic] = []
        for topic in topics {
            if (topic.readPercent < 100 && topic.readPercent > 0) {
                continueReading.append(topic)
            }
        }
        return continueReading
    }
    
    var startReadingLiked: [Topic] {
        var startReadingLiked: [Topic] = []
        for topic in topics {
            if (topic.thumbsUp && topic.readPercent == 0) {
                startReadingLiked.append(topic)
            }
        }
        return startReadingLiked
    }
    
    var startReadingDisliked: [Topic] {
        var startReadingDisliked: [Topic] = []
        for topic in topics {
            if (!topic.thumbsUp && topic.readPercent == 0) {
                startReadingDisliked.append(topic)
            }
        }
        return startReadingDisliked
    }
    
    var body: some View {
        ZStack {
            Color.tan
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Continue Reading")
                        .bold()
                        .foregroundStyle(.darkGreen)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(continueReading) { topic in
                                NavigationLink {
                                    TopicDetail(topic: topic)
                                } label: {
                                    SuggestedTopicCard(topic: topic)
                                        .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                    
                    Text("Start Reading Something You've Liked")
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(startReadingLiked) { topic in
                                NavigationLink {
                                    TopicDetail(topic: topic)
                                } label: {
                                    SuggestedTopicCard(topic: topic)
                                        .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                    Text("Consider Reading Something You've Disliked")
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(startReadingDisliked) { topic in
                                NavigationLink {
                                    TopicDetail(topic: topic)
                                } label: {
                                    SuggestedTopicCard(topic: topic)
                                        .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                    
                }.padding(.horizontal, 10)
            }
        }
    
    }
}


#Preview {
    SuggestedTopicsView()
}
