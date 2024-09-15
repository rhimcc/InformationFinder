import SwiftUI

struct TopicRow: View {
    var filterViewModel: FilterViewModel?
    var topic: Topic
    var colour: Color

    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: topic.imageURL)) { phase in
                     if let image = phase.image {
                         image.resizable()
                             .scaledToFill()
                             .frame(width: 120, height: 120)
                             .clipped()
                     } else {
                         LottieView(animationFileName: "AnimationDarkGreen", loopMode: .loop)
                     }
                 }

                VStack(alignment: .leading) {
                    Text(topic.topicName)
                        .foregroundColor(.darkGreen)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
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
                        if let filterViewModel = filterViewModel {
                            filterViewModel.applyFilters()
                        }
                    } label: {
                        Image(systemName: topic.thumbsUp ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                            .foregroundColor(.darkGreen)
                            .font(.system(size: 30))
                    }
                    Text("\(topic.readPercent)%")
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
