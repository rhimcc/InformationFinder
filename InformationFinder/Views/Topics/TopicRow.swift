import SwiftUI

struct TopicRow: View {
    var filterViewModel: FilterViewModel?
    var topic: Topic
    var colour: Color

    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: topic.imageURL)) { phase in // gets image from URL
                     if let image = phase.image {
                         image.resizable()
                             .scaledToFill()
                             .frame(width: 120, height: 120)
                             .clipped()
                     } else {
                         LottieView(animationFileName: "AnimationDarkGreen", loopMode: .loop) // loading animation
                     }
                 }

                VStack(alignment: .leading) {
                    Text(topic.topicName) // topic name
                        .foregroundColor(.darkGreen)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 150, alignment: .leading)
                        .bold()
                        .font(.system(size: 20))
                    
                    Text(topic.category) // topic category
                        .foregroundColor(colour == .lightGreen ? .midDarkGreen : .tan) //changes the colour depending on the background colour, set in the call of Topic Row
                }
                .padding(.leading, 10)
                Spacer()
                VStack (alignment: .trailing) {
                    if (!topic.beenSwiped) { // sets icon seen in search bar in home view
                        Image(systemName: "minus.circle")
                            .foregroundColor(.darkGreen)
                            .font(.system(size: 30))
                        
                    } else {
                        Button { // toggles thumbsUp/thumbsDown, and sets the image accordingly
                            topic.thumbsUp.toggle()
                            if let filterViewModel = filterViewModel {
                                filterViewModel.applyFilters() //reapplies the filters based on the change of the topic's thumb condition
                            }
                            
                        } label: {
                            Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                                .foregroundColor(.darkGreen)
                                .font(.system(size: 30))
                        }
                        
                    }
                
                    Text("\(topic.readPercent)%") // topics read percent
                        .foregroundColor(.darkGreen)
                        .padding(.top, 20)
                    
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
