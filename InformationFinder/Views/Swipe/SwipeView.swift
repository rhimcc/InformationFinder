//
//  SwipeView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 28/8/2024.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var topicList: [Topic]
    @State private var swipeRight: Bool = false
     var cardWidth = 300
     var cardHeight = 500
    @State private var cardPosition: CGFloat = UIScreen.main.bounds.width / 2

    var body: some View {
        let topicViewModel: TopicViewModel = TopicViewModel(topicList: topicList)
        let unswipedTopics = topicViewModel.getUnswipedTopics()
        ZStack {
            Color.tan
                .edgesIgnoringSafeArea(.all)

            VStack {
                ZStack {
                    ForEach(unswipedTopics) { topic in
                        TopicCard(topicViewModel: topicViewModel, cardIndex: topicViewModel.getIndexOfTopic(topic: topic) ?? 0, cardPosition: $cardPosition)
                            .frame(width: 300, height: 500)
                            .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            .position(x: cardPosition, y: 300)
                    }
                    if (unswipedTopics.isEmpty) {
                        VStack (alignment: .center){
                        
                            Image(systemName: "brain")
                                .font(.system(size: 70))
                                .padding(30)
                            Text("You have swiped on every topic!")
                                .bold()
                                .font(.system(size: 25))
                                .padding(.bottom, 10)
                            Text("Look at the brain bank\n to get learning!")
                                .bold()
                                .font(.system(size: 15))
                        }
                        .foregroundColor(.white)
                            .frame(width: 300, height: 500, alignment: .center)
                            .multilineTextAlignment(.center)

                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.darkGreen)
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )

                    }
                }
                
                Button {
                    for topic in topicList {
                        modelContext.delete(topic)
                    }
                } label : {
                    Text("Delete all")
                }
                
            }
        }
        .onAppear {
            print(unswipedTopics)
        }
    }

    }

