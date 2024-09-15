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
            if (topic.beenSwiped && topic.thumbsUp && topic.readPercent == 0) {
                startReadingLiked.append(topic)
            }
        }
        return startReadingLiked
    }
    
    var startReadingDisliked: [Topic] {
        var startReadingDisliked: [Topic] = []
        for topic in topics {
            if (!topic.thumbsUp && topic.beenSwiped) {
                if (topic.readPercent == 0) {
                    startReadingDisliked.append(topic)
                }
            }
        }
        return startReadingDisliked

    }
    
    var disliked: [Topic] {
        var disliked: [Topic] = []
        for topic in topics {
            if (!topic.thumbsUp && topic.beenSwiped) {
                disliked.append(topic)
            }
        }
        return disliked
    }
    
    var liked: [Topic] {
        var liked: [Topic] = []
        for topic in topics {
            if (topic.thumbsUp && topic.beenSwiped) {
                liked.append(topic)
            }
        }
        return liked
    }
    
    var unswiped: [Topic] {
        var unswiped: [Topic] = []
        for topic in topics {
            if !topic.beenSwiped {
                unswiped.append(topic)
            }
        }
        return unswiped
    }
    
//    var startReadingDisliked: [Topic] {
//        var startReadingDisliked: [Topic] = []
//        for topic in topics {
//            if (!topic.thumbsUp && topic.readPercent == 0) {
//                startReadingDisliked.append(topic)
//            }
//        }
//        return startReadingDisliked
//    }
    
    var body: some View {
        ZStack {
            Color.tan
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Continue Reading")
                        .bold()
                        .foregroundStyle(.darkGreen)
                    if (continueReading.isEmpty) {
                        ErrorView(text: "You have not began reading anything.", tip: "Choose any topic and start reading!")
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(continueReading) { topic in
                                    NavigationLink {
                                        TopicDetail(scrollPosition: topic.scrollPosition, topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Start Reading Something You've Liked")
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (liked.isEmpty) {
                        ErrorView(text: "You have not liked anything.", tip: "Start swiping right!")
                    } else if (startReadingLiked.isEmpty) {
                        ErrorView(text: "You have read everything you've liked", tip: "Swipe right in Swipe mode or tap the thumb in Brain Bank to like more!")
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(startReadingLiked) { topic in
                                    NavigationLink {
                                        TopicDetail(scrollPosition: topic.scrollPosition, topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    Text("Consider Reading Something You've Disliked")
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (disliked.isEmpty) {
                        ErrorView(text: "You have not disliked anything.", tip: "That's fine! Keep reading what you like!")
                        
                    } else if (startReadingDisliked.isEmpty) {
                        ErrorView(text: "You read everything you have disliked", tip: "Did you really still dislike them?")
                        
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(startReadingDisliked) { topic in
                                    NavigationLink {
                                        TopicDetail(scrollPosition: topic.scrollPosition, topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Some Topics You May Not Have Seen")
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (unswiped.isEmpty) {
                        ErrorView(text: "You have seen everything!", tip: "Go to the Brain Bank to read them!")
                        
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(unswiped) { topic in
                                    NavigationLink {
                                        TopicDetail(scrollPosition: topic.scrollPosition, topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
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
