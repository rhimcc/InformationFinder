import SwiftUI

struct TopicRow: View {
    var topic: Topic
    var colour: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(colour)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                .padding(.bottom, 4)
            
            HStack {
                AsyncImage(url: URL(string: topic.imageURL)) { image in
                    image.image?.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
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
                        
                    } label : {
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
            }
            .padding()
        }
        .padding([.top, .leading, .trailing], 10)
    }
}
