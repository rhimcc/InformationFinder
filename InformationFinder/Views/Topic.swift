//
//  Topic.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import Foundation
import SwiftData

@Model
class Topic {
    var topicName: String
    var thumbsUp: Bool
    var imageURL: String
    var beenSwiped: Bool
    var topicDescription: String
    var topicInfo: String
    
    init(topicName: String, topicDescription: String, topicInfo: String, thumbsUp: Bool, beenSwiped: Bool, imageURL: String){
        self.topicName = topicName
        self.topicDescription = topicDescription
        self.topicInfo = topicInfo
        self.thumbsUp = thumbsUp
        self.beenSwiped = beenSwiped
        self.imageURL = imageURL
    }
}
