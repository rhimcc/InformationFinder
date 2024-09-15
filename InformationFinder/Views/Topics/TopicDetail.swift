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
                            AsyncImage(url: URL(string: topic.imageURL)) { phase in // gets image from URL
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width) //scales to fill the width of the screen
                                        .clipped() //clips the image to fit in the bounds wihtout messing up aspect ratio
                                } else {
                                    LottieView(animationFileName: "AnimationDarkGreen", loopMode: .loop) // loading animation
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                                }
                            }
                            
                            VStack {
                                HStack {
                                    if (topic.readPercent == 100) { // if the topic has been read, option to reset the percentage
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
//                                        .position(x: 50, y: -50)
                                    }
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .opacity(0.75)
                                            .foregroundColor(.tan)
                                        
                                        Button {
                                            if (topic.beenSwiped) { // if it has already been swiped, it will interchange between thumbs up and down
                                                topic.thumbsUp.toggle()
                                            } else {
                                                topic.thumbsUp = true // if it has not been swiped, it will set thumbsUp to true and been swiped to true, so if it is clicked again it will then toggle as above
                                                topic.beenSwiped = true
                                            }
                                        } label: {
                                            if !topic.beenSwiped { // icon if it has not been swiped
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.darkGreen)
                                                    .font(.system(size: 35))
                                            } else {
                                                Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill") // icon if it has been swiped
                                                    .font(.system(size: 35))
                                                    .foregroundColor(.darkGreen)
                                            }
                                        }
                                    }
                                }
                                .padding(5)
                                .frame(alignment: .center)
                                Spacer()
                                if topic.imageCredit != "" { // image credit, only if required
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
                        
                        Text(topic.topicName) // topic name
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.darkGreen)
                            .padding(5)

                        Text(topic.topicDescription) // topic description
                            .font(.system(size: 15))
                            .italic()
                            .padding(5)
                            .foregroundColor(.gray)

                        HStack {
                            Text("\(topic.wordCount) words") // word count
                            Text("|")
                            Text(topic.category) // category
                                .bold()
                            Text("|")
                            Text("~ \(topic.calculatedTime) minutes") // reading minutes
                        }
                        .foregroundColor(.gray)
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                topContentHeight = geometry.size.height // gets the height of the top part of content, used for percentage tracking
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
                                        let scrollOffset = -(newY - topContentHeight) // calculates the y offset without the topContentHeight
                                        let newScrollPosition = min(max(scrollOffset, 0), contentHeight - UIScreen.main.bounds.height)
                                        if newScrollPosition > topic.scrollPosition { // if it is lower than the previous position, it is stored
                                            topic.scrollPosition = newScrollPosition
                                            topic.readPercent = getPercentage()
                                        }
                                    }
                            })
                    }
                }
                .background(.tan)

                HStack {
                    ProgressView(value: Float(topic.scrollPosition), total: Float(contentHeight - UIScreen.main.bounds.height)) // shows the progress of the scrolling
                        .tint(.darkGreen)
                        .background(.tan)
                        .padding(.horizontal, 10)

                    Text("\(getPercentage())%") // percentage value of reading progress
                        .padding(.trailing, 10)
                }
                .padding(.top, 10)
            }
        
    }

    func getPercentage() -> Int {
        let progressRatio = topic.scrollPosition / (contentHeight - UIScreen.main.bounds.height) // calculates the value of the reading progress
        return Int(progressRatio * 100) // returns as a percentage
    }
}
