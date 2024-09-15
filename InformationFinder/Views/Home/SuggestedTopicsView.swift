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
        return getPartiallyRead() //shows any topic that has been partially read
    }
    
    var startReadingLiked: [Topic] {
        return getLiked().filter(getUnread().contains).filter(getSwiped().contains) // shows topics which have been swiped, liked, and have not been  read
    }
    
    var startReadingDisliked: [Topic] {
        return getDisliked().filter(getUnread().contains).filter(getSwiped().contains) // shows topics which have been swiped, disliked, and have not been read
    }
    
    var body: some View {
        ZStack {
            Color.tan // background colour
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Continue Reading") //continue reading heading
                        .bold()
                        .foregroundStyle(.darkGreen)
                    if (continueReading.isEmpty) {
                        ErrorView(text: "You have not began reading anything.", tip: "Choose any topic and start reading!") // if there are no topics that have not been partially read
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(continueReading) { topic in // if there are topics that have been partially read
                                    NavigationLink {
                                        TopicDetail(topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Start Reading Something You've Liked") // start reading liked heading
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (getLiked().isEmpty) {
                        ErrorView(text: "You have not liked anything.", tip: "Start swiping right!") // if the user has not liked anything
                    } else if (startReadingLiked.isEmpty) {
                        ErrorView(text: "You have read everything you've liked", tip: "Swipe right in Swipe mode or tap the thumb in Brain Bank to like more!") // if the user has liked topics, but has read all of the liked topics
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(startReadingLiked) { topic in // shows each of the topics which have been liked and started to have been read
                                    NavigationLink {
                                        TopicDetail(topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    Text("Consider Reading Something You've Disliked") // start reading disliked heading
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (getDisliked().filter(getSwiped().contains).isEmpty ) { //if the user has not disliked anything
                        ErrorView(text: "You have not disliked anything.", tip: "That's fine! Keep reading what you like!")
                        
                    } else if (startReadingDisliked.isEmpty) { // if the user has disliked things, but they have finished reading each of the disliked topics
                        ErrorView(text: "You read everything you have disliked", tip: "Did you really still dislike them?")
                        
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(startReadingDisliked) { topic in // shows each of the disliked topics that they have not begun reading
                                    NavigationLink {
                                        TopicDetail(topic: topic)
                                    } label: {
                                        SuggestedTopicCard(topic: topic)
                                            .padding(.trailing, 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Some Topics You May Not Have Seen") // unswiped topics
                        .bold()
                        .foregroundStyle(.darkGreen)
                        .padding(.top, 20)
                    if (getUnswiped().isEmpty) { // if the user has swiped on all of the available topics
                        ErrorView(text: "You have seen everything!", tip: "Go to the Brain Bank to read them!")
                        
                    } else { // topics that the user has not swiped on
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(getUnswiped()) { topic in
                                    NavigationLink {
                                        TopicDetail(topic: topic)
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
    
    func getDisliked() -> [Topic] {
        return topics.filter{!$0.thumbsUp} //any topic which has been disliked, including the initialised state
    }
    
    func getSwiped() -> [Topic] {
        return topics.filter {$0.beenSwiped} // any topic which has been swiped on
    }
    
    func getUnswiped() -> [Topic] {
        return topics.filter {!$0.beenSwiped} // any topic which has not been swiped on
    }
    
    func getLiked() -> [Topic] {
        return topics.filter{$0.thumbsUp} // any topic which has been liked by the user
    }
    
    func getUnread() -> [Topic] {
        return topics.filter{$0.readPercent == 0} // any topic which the user has not begun reading
    }
    
    func getPartiallyRead() -> [Topic] {
        return topics.filter{$0.readPercent > 0 && $0.readPercent < 100} // any topic which the user has started to read, but not completed
    }
    
    
}


//#Preview {
//    SuggestedTopicsView()
//}
