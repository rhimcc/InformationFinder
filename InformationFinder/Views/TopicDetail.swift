import SwiftUI

struct TopicDetail: View {
    @State private var scrollPosition: CGFloat = 0
    @State private var scrollHeight: CGFloat = 1 // Initialize with a small positive value to avoid division by zero
    @State private var contentHeight: CGFloat = 0

    var topic: Topic

    var body: some View {
        ZStack {
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

                    Text(.init(topic.topicInfo))
                        .padding(20)

                    Button("Done") {
                        // Button action
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            contentHeight = geometry.size.height
                            scrollHeight = max(contentHeight, UIScreen.main.bounds.height)
                            print("Content Height on Appear: \(contentHeight)")
                            print("Scroll Height on Appear: \(scrollHeight)")
                        }
                        .onChange(of: geometry.size.height) { newHeight in
                            contentHeight = newHeight
                            scrollHeight = max(contentHeight, UIScreen.main.bounds.height)
                            print("Content Height on Change: \(contentHeight)")
                            print("Scroll Height on Change: \(scrollHeight)")
                        }
                        .onChange(of: geometry.frame(in: .global).origin.y) { newY in
                            let scrollOffset = -newY
                            scrollPosition = min(max(scrollOffset, 0), scrollHeight - UIScreen.main.bounds.height)
                            print("Scroll Position: \(scrollPosition)")
                        }
                })
            }
            .coordinateSpace(name: "scroll")
            .background(.tan)

            ProgressView(value: Float(scrollPosition), total: Float(scrollHeight - UIScreen.main.bounds.height))
                
        }
    }
}
