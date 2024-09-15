import SwiftUI

struct TopicDetail: View {
    @State var scrollPosition: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @State private var topContentHeight: CGFloat = 0

    var topic: Topic

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            VStack {
                ScrollView {
                    VStack {
                        ZStack {
                            AsyncImage(url: URL(string: topic.imageURL)) { image in
                                image.image?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                                    .clipped()
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            }

                            ZStack {
                                Circle()
                                    .frame(width: 75, height: 75)
                                    .opacity(0.75)
                                    .foregroundColor(.tan)

                                Button {
                                    topic.thumbsUp.toggle()
                                } label: {
                                    Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                                        .font(.system(size: 35))
                                        .foregroundColor(.darkGreen)
                                }
                            }
                            .position(x: UIScreen.main.bounds.width - 50, y: 50)
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
                        // Scrollable content
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
//                                            topic.scrollPosition = scrollPosition
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
    }

    func getPercentage() -> Int {
        let progressRatio = topic.scrollPosition / (contentHeight - UIScreen.main.bounds.height)
        return Int(progressRatio * 100)
    }
}
