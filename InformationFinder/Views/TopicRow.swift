import SwiftUI

struct TopicRow: View {
    var topic: Topic
    var colour: Color

    var body: some View {
            
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
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.darkGreen)
                    
                    Text(topic.category)
                        .foregroundColor(colour == .tan ? .gray : .tan)
                }
                .padding(.leading, 10)
                Spacer()
                VStack {
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
