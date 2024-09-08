import SwiftUI

struct TopicRow: View {
    var topic: Topic
    var colour: Color

    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: topic.imageURL)) { image in
                    image.image?.resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                    
                }
                VStack(alignment: .leading) {
                    Text(topic.topicName)
                        .foregroundColor(.darkGreen)
//                        .scaledToFill()
                        .lineLimit(2)  // Allows the text to wrap into two lines if needed
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion
                        .frame(maxWidth: 150, alignment: .leading)
                        .bold()
                        .font(.system(size: 20))
                    
                    Text(topic.category)
                        .foregroundColor(colour == .lightGreen ? .midDarkGreen : .tan)
                }
                .padding(.leading, 10)
                Spacer()
                VStack (alignment: .trailing) {
                    Button {
                        topic.thumbsUp.toggle()
                    } label: {
                        Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                            .foregroundColor(.darkGreen)
                            .font(.system(size: 30))
                    }
                    HStack {
                        Text("READ NOW")
                        Image(systemName: "arrowtriangle.right")
                    }
                    .padding([.top], 15)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.darkGreen)
                }
                .padding()
                
            }
            .frame(height: 120)
            .background(colour)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.33), radius: 1, x: 2, y: 2)
            .padding(.vertical, 2)
        }
    }
      
    
}
