import SwiftUI

struct TopicDetail: View {
    @State private var scrollPosition: CGFloat = 0
    @State private var scrollHeight: CGFloat = 1 // Initialize with a small positive value to avoid division by zero
    @State private var topContentHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0

    var topic: Topic

    var body: some View {
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
                            // Capture the height of the non-scrollable top content
                            topContentHeight = geometry.size.height
                        }
                })

                // This is the scrollable content that will be tracked
                Text(.init(topic.topicInfo))
                    .padding(20)
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                // Set content height for the scrollable area
                                contentHeight = geometry.size.height
                                scrollHeight = topContentHeight + contentHeight
                            }

                            .onChange(of: geometry.frame(in: .global).origin.y) { newY in
                                let scrollOffset = -(newY - topContentHeight)
                                let newScrollPosition = min(max(scrollOffset, 0), contentHeight - UIScreen.main.bounds.height)
                                if (newScrollPosition > scrollPosition) {
                                    scrollPosition = newScrollPosition
                                    topic.readPercent = getPercentage()
                                }
                            }
                    })
            }
            .background(.tan)

            // Progress View
            HStack {
                ProgressView(value: Float(scrollPosition), total: Float(contentHeight - UIScreen.main.bounds.height))
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
        let progressRatio = scrollPosition / (contentHeight - UIScreen.main.bounds.height)
        return Int(progressRatio * 100)
    }
}
