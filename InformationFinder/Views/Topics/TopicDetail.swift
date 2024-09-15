import SwiftUI

struct TopicDetail: View {
    @State var scrollPosition: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @State private var topContentHeight: CGFloat = 0

    var topic: Topic

    var body: some View {
            VStack {
                ScrollView {
                    VStack {
                        ZStack {
                            AsyncImage(url: URL(string: topic.imageURL)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                } else {
                                    LottieView(animationFileName: "AnimationDarkGreen", loopMode: .loop)
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                                }
                            }
                            
                            VStack {
                                
                                ZStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .opacity(0.75)
                                        .foregroundColor(.tan)
                                    
                                    Button {
                                        if (topic.beenSwiped) {
                                            topic.thumbsUp.toggle()
                                        } else {
                                            topic.thumbsUp = true
                                            topic.beenSwiped = true
                                        }
                                    } label: {
                                        if !topic.beenSwiped {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.darkGreen)
                                                .font(.system(size: 35))
                                        } else {
                                            Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                                                .font(.system(size: 35))
                                                .foregroundColor(.darkGreen)
                                        }
                                    }
                                }
                                .position(x: UIScreen.main.bounds.width - 50, y: 50)
                                
                                if (topic.readPercent == 100) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 80, height: 40)
                                            .opacity(0.75)
                                            .foregroundColor(.tan)
                                        
                                        Button {
                                            topic.scrollPosition = 0
                                            topic.readPercent = 0
                                        } label: {
                                            Text("Re-Read")
                                                .bold()
                                                .foregroundStyle(.darkGreen)
                                        }
                                    }
                                    .position(x: 50, y: 40)
                                }
                                Spacer()
                                if topic.imageCredit != "" {
                                    ZStack {
                                        
                                        Text("Image: \(topic.imageCredit)")
                                           
                                            .foregroundColor(.darkGreen)
                                            .bold()
                                            .italic()
                                            .padding()

                                            .background(RoundedRectangle(cornerRadius: 20)
                                                .frame(height: 40)
                                                .opacity(0.75)
                                                .foregroundColor(.tan)
                                            )
                                        
                                    }   
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        
                        

                        Text(topic.topicName)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.darkGreen)
                            .padding(5)

                        Text(topic.topicDescription)
                            .font(.system(size: 15))
                            .italic()
                            .padding(5)
                            .foregroundColor(.gray)

                        HStack {
                            Text("\(topic.wordCount) words")
                            Text("|")
                            Text(topic.category)
                                .bold()
                            Text("|")
                            Text("~ \(topic.calculatedTime) minutes")
                        }
                        .foregroundColor(.gray)
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                topContentHeight = geometry.size.height
                            }
                    })

                    VStack {
                        Text(.init(topic.topicInfo))
                            .padding(20)
                            .background(GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        contentHeight = geometry.size.height
                                    }
                                    .onChange(of: geometry.frame(in: .global).origin.y) { newY in
                                        let scrollOffset = -(newY - topContentHeight)
                                        let newScrollPosition = min(max(scrollOffset, 0), contentHeight - UIScreen.main.bounds.height)
                                        if newScrollPosition > topic.scrollPosition {
                                            topic.scrollPosition = newScrollPosition
                                            topic.readPercent = getPercentage()
                                        }
                                    }
                            })
                    }
                }
                .background(.tan)

                HStack {
                    ProgressView(value: Float(topic.scrollPosition), total: Float(contentHeight - UIScreen.main.bounds.height))
                        .tint(.darkGreen)
                        .background(.tan)
                        .padding(.horizontal, 10)

                    Text("\(getPercentage())%")
                        .padding(.trailing, 10)
                }
                .padding(.top, 10)
            }
        
    }

    func getPercentage() -> Int {
        let progressRatio = topic.scrollPosition / (contentHeight - UIScreen.main.bounds.height)
        return Int(progressRatio * 100)
    }
}
