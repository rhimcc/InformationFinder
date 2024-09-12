import SwiftUI
import SwiftData

struct SuggestedTopicCard: View {
    var topic: Topic
    var cardWidth: CGFloat = 150
    var cardHeight: CGFloat = 200

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.darkGreen)
                .frame(width: cardWidth, height: cardHeight)
            
            VStack(spacing: 0) {  // Set spacing to 0 so that image and text are tightly aligned
                AsyncImage(url: URL(string: topic.imageURL)) { image in
                    image.image?.resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardWidth*2/3)
                        .clipped()
                }
                
                Text(topic.topicName)
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
                    Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                        .foregroundColor(.tan)
                        .padding(.leading, 10)

                    Spacer()
                    Text("\(topic.readPercent)%")
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
