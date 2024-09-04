import SwiftUI
import SwiftData

struct TopicCard: View {
    var topicViewModel: TopicViewModel
    @Query var topicList: [Topic]
//    var topic: Topic
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
                if offset > 20 {
                    topicList[cardIndex].thumbsUp = true
                    topicList[cardIndex].beenSwiped = true
                    withAnimation {
                        offset = screenWidth
                    }
                } else {
                    if offset < -20 {
                        topicList[cardIndex].thumbsUp = false
                        topicList[cardIndex].beenSwiped = true

                        withAnimation {
                            offset = -screenWidth
                        }
                    } else {
                        withAnimation {
                            offset = 0
                        }
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {


            VStack {
                AsyncImage(url: URL(string: topicList[cardIndex].imageURL)) { image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cardWidth, height: cardWidth)
                        .clipped()
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        .mask{
                            Rectangle()
//                                .fill(.darkGreen)
                                .cornerRadius(30)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                }
                
                Text(topicList[cardIndex].topicName)
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
            .padding()
        }
        .frame(width: cardWidth, height: cardHeight)
        .offset(x: offset)
        .gesture(dragGesture)
//        .onAppear {
//            print("card index ", cardIndex)
//            print("card at card index is ", topicList[cardIndex].topicName)
//        }
//        .onAppear {
//            topicViewModel.setActiveTopic(topic: topic)
//        }
    }
       
}

//#Preview {
//    TopicCard(topic: Topic(topicName: "Name", topicDescription: "Description", topicInfo: "Information", category: "Category", imageURL: "url", beenSwiped: false, thumbsUp: true), cardPosition: .constant(UIScreen.main.bounds.width/2))
//}
