//
//  TopicCard.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import SwiftUI

struct TopicCard: View {
    var topic: Topic
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            
            VStack {
                AsyncImage(url: URL(string: topic.imageURL)) { image in
                    image.image?.resizable()
                        .aspectRatio(contentMode: .fill)
                    
                }
                Text(topic.topicName)
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding([.top], 20)
                
            }
            
        }
    }
}

#Preview {
    TopicCard(topic: Topic(topicName: "Black Hole", isFavourited: true, imageURL: "https://upload.wikimedia.org/wikipedia/commons/4/4f/Black_hole_-_Messier_87_crop_max_res.jpg"))
}
