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
    var topicDescription: String
    var topicInfo: String
    var category: String
    var imageURL: String
    var beenSwiped: Bool
    var thumbsUp: Bool
    var wordCount: Int {
        let components = self.topicInfo.components(separatedBy: .whitespacesAndNewlines)
        let wordCount = components.count
        return wordCount
    }
    
    var calculatedTime: Int {
        let time = (Double(wordCount) / 250.0).rounded()
        return Int(time)
    }
    
    init(topicName: String, topicDescription: String, topicInfo: String, category: String, imageURL: String, beenSwiped: Bool, thumbsUp: Bool){
        self.topicName = topicName
        self.topicDescription = topicDescription
        self.topicInfo = topicInfo
        self.imageURL = imageURL
        self.beenSwiped = beenSwiped
        self.thumbsUp = thumbsUp
        self.category = category
    }
    
}
