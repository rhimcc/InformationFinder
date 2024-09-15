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
    @State private var helpPopUp = false

    var body: some View {
        let topicViewModel: TopicViewModel = TopicViewModel(topicList: topicList)
        let unswipedTopics = topicViewModel.getUnswipedTopics()
        ZStack {
            Color.tan
                .edgesIgnoringSafeArea(.all)
            if helpPopUp {
                         Color.black.opacity(0.6)
                             .edgesIgnoringSafeArea(.all)
                     }
            
            if (helpPopUp) {
                
                VStack (alignment: .center){
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.darkTan)
                            .frame(width: 50, height: 80)
                            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.darkGreen, lineWidth: 5)
                                    .rotationEffect(Angle(degrees: 20))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.darkGreen, lineWidth: 5)
                                    .rotationEffect(Angle(degrees: -20))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.darkTan)
                                    .stroke(.darkGreen, lineWidth: 5)
//                                    .rotationEffect(Angle(degrees: -20))
                            )
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Image(systemName: "arrowshape.backward.fill")
                                .font(.system(size: 30))
                            Text("Dislike")
                                .bold()
                            
                        }.padding(.horizontal, 30)

                        VStack (alignment: .trailing){
                            Image(systemName: "arrowshape.forward.fill")
                                .font(.system(size: 30))
                            Text("Like")
                                .bold()
                        }.padding(.horizontal, 30)


                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)

                    Text("Drag topics")
                        .bold()
                        .font(.system(size: 25))
                        .padding(.bottom, 10)
                    Text("Look at your brain bank to view all topics after you swipe on them!")
                        .bold()
                        .font(.system(size: 15))
                }    .foregroundColor(.darkGreen)
                    .frame(width: 300, height: 500, alignment: .center)
                    .multilineTextAlignment(.center)
                
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.darkTan)
                            .aspectRatio(CGSize(width: cardWidth, height: cardHeight), contentMode: .fit)
                            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                    )
            }
            Spacer()
            
            VStack {
                Spacer()
                Spacer()
                
                    HStack {
                        Spacer()
                        ZStack {
                            Text("SWIPE TOPICS")
                                .bold()
                                .font(.system(size: 30))
                                .foregroundStyle(.tan)
                        }
                        Button {
                            helpPopUp.toggle()
                        } label : {
                            Image(systemName: helpPopUp ? "questionmark.circle.fill" : "questionmark.circle")
                                .foregroundStyle(.tan)
                                .font(.system(size: 30))
                                .padding(.horizontal, 30)
                        }
                      
                        
                    }.background(RoundedRectangle(cornerRadius: 20)
                        .fill(.darkGreen)
                        .frame(width: 350, height: 70, alignment: .center)
                        .padding(20))
                  
                
                ZStack {
                    Spacer()
                    if (!helpPopUp) {
                    

      
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
                }
                
                
            }
        }
    }

    }

