import SwiftUI

struct TopicDetail: View {
    var topic: Topic
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    AsyncImage(url: URL(string: topic.imageURL)) { image in
                        image.image?.resizable()
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            .padding(.bottom, 20)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
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
                        
                        
                    }.position(x: UIScreen.main.bounds.width - 50, y: 50)

                  
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

                }.foregroundColor(.gray)
              
                Text(topic.topicInfo)
                    .padding(20)

                
            }
        }.background(.tan)
    }
}

//#Preview {
//    TopicDetail()
//}
