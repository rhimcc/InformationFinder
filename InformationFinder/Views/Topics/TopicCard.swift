import SwiftUI
import SwiftData

struct TopicCard: View {
    var topicViewModel: TopicViewModel
    @Query var topicList: [Topic]
    var cardWidth: CGFloat = 300
    var cardHeight: CGFloat = 500
    var cardIndex: Int
    @State private var offset = CGFloat.zero
    @Binding var cardPosition: CGFloat

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation.width //gets how far the card has been moved
            }
            .onEnded { _ in
                let screenWidth = UIScreen.main.bounds.width
                withAnimation {
                    if offset > 50 { // if it is swiped right far enough, it will mark the card as swiped and thumbs-upped
                        topicList[cardIndex].thumbsUp = true
                        topicList[cardIndex].beenSwiped = true
                        offset = screenWidth // takes the card off the screen
                    } else if offset < -50 { // if it is swiped left far enough, it will mark the card as swiped and thumbs-downed
                        topicList[cardIndex].thumbsUp = false
                        topicList[cardIndex].beenSwiped = true
                        offset = -screenWidth // takes the card off the screen
                    } else {
                        offset = 0 //if it is only a minor swipe, it will set the position back to 0 to avoid unintentional swipes
                    }
                }
            }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20) // background rectangle
                .fill(.darkGreen)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .frame(width: cardWidth, height: cardHeight)

            VStack(spacing: 0) {
                AsyncImage(url: URL(string: topicList[cardIndex].imageURL)) { phase in // gets image from URL
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: cardWidth, height: cardWidth)
                            .clipped()
                    } else {
                        LottieView(animationFileName: "AnimationTan", loopMode: .loop) // loading animation
                    }
                }
                
                Spacer()
                Text(topicList[cardIndex].topicName) // Name of the topic
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
                    .bold()
                    .multilineTextAlignment(.center)
                Text(topicList[cardIndex].category) // Category of the topic
                    .bold()
                Spacer()
                HStack {
                    Text("\(topicList[cardIndex].wordCount) words") // word count
            
                    Text("|")
                    Text("~ \(topicList[cardIndex].calculatedTime) minutes") // approximate reading time
                }

                Spacer()
                
            }
            .foregroundStyle(.tan)
            .frame(width: cardWidth, height: cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 20)) // Apply corner radius to the entire content of the card
        }
        .offset(x: offset) // sets the position of the card to the offset with the drag gesture
        .gesture(dragGesture) //applies the drag gesture
    }
}
