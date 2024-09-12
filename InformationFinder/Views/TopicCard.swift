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
                offset = value.translation.width
            }
            .onEnded { _ in
                let screenWidth = UIScreen.main.bounds.width
                withAnimation {
                    if offset > 50 {
                        topicList[cardIndex].thumbsUp = true
                        topicList[cardIndex].beenSwiped = true
                        offset = screenWidth
                    } else if offset < -50 {
                        topicList[cardIndex].thumbsUp = false
                        topicList[cardIndex].beenSwiped = true
                        offset = -screenWidth
                    } else {
                        offset = 0
                    }
                }
            }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.darkGreen)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .frame(width: cardWidth, height: cardHeight)

            VStack(spacing: 0) {  // Set spacing to 0 so that image and text are tightly aligned
                AsyncImage(url: URL(string: topicList[cardIndex].imageURL)) { image in
                    image.image?.resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardWidth)
                        .clipped()
                    
                }
                Spacer()
                Text(topicList[cardIndex].topicName)
//                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity) // Ensure the text spans the full width of the card
                    .font(.system(size: 30))
                    .bold()

                Spacer()
            }
            .frame(width: cardWidth, height: cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 20)) // Apply corner radius to the entire content of the card
        }
        .offset(x: offset)
        .gesture(dragGesture)
    }
}
