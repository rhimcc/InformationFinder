import SwiftUI
import SwiftData

struct SuggestedTopicCard: View {
    var topic: Topic
    var cardWidth: CGFloat = 150
    var cardHeight: CGFloat = 200

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20) // background rectangle
                .fill(.darkGreen)
                .frame(width: cardWidth, height: cardHeight)
            
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: topic.imageURL)) { phase in // image from URL
                    if let image = phase.image {
                        image.resizable()
                    } else {
                        LottieView(animationFileName: "AnimationTan", loopMode: .loop) // animation for loading
                            .frame(width: cardWidth, height: cardWidth*2/3)
                    }
                }
                
                Text(topic.topicName) // topic name
                    .foregroundColor(.tan)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 150, alignment: .center)
                    .bold()
                    .font(.system(size: 18))
                    .padding(.top, 10)
                Spacer()
                HStack {
                    if (!topic.beenSwiped) { // icon if the topic has not been swiped on
                        Image(systemName: "minus.circle")
                            .foregroundColor(.tan)
                            .padding(.leading, 10)
                    } else { // icon if the topic has been swiped on, depending on if its been thumbsed up or down
                        Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                            .foregroundColor(.tan)
                            .padding(.leading, 10)
                    }
                    

                    Spacer()
                    Text("\(topic.readPercent)%") // read percent of topic
                        .bold()
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                }.padding(.bottom, 10)
            }
            .frame(width: cardWidth, height: cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .shadow(color: .black.opacity(0.33), radius: 1, x: 2, y: 2)

    }
}
