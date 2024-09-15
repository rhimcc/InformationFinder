//
//  Topic.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import Foundation
import SwiftData

@Model
class Topic: Decodable {
    var topicName: String
    var topicDescription: String
    var topicInfo: String
    var category: String
    var imageURL: String
    var beenSwiped: Bool
    var thumbsUp: Bool
    var imageCredit: String
    var readPercent: Int
    var scrollPosition: Double
    
    var wordCount: Int { //calculates the amount of words that are held in the topic info
        let components = self.topicInfo.components(separatedBy: .whitespacesAndNewlines)
        let wordCount = components.count
        return wordCount
    }
    
    var calculatedTime: Int { //calculates the approximate time to read the information, based on average reading times
        let time = (Double(wordCount) / 230.0).rounded()
        return Int(time)
    }
    
    init(topicName: String, topicDescription: String, topicInfo: String, category: String, imageURL: String, imageCredit: String){ // initalising all values for topics
        self.topicName = topicName
        self.topicDescription = topicDescription
        self.topicInfo = topicInfo
        self.imageURL = imageURL
        self.beenSwiped = false
        self.thumbsUp = false
        self.category = category
        self.readPercent = 0
        self.imageCredit = imageCredit
        self.scrollPosition = 0.0
    }
    
    required init(from decoder: Decoder) throws { //initialises all of the variables for JSON decoding
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.topicName = try container.decode(String.self, forKey: .topicName)
            self.topicDescription = try container.decode(String.self, forKey: .topicDescription)
            self.topicInfo = try container.decode(String.self, forKey: .topicInfo)
            self.category = try container.decode(String.self, forKey: .category)
            self.imageURL = try container.decode(String.self, forKey: .imageURL)
            self.thumbsUp = false
            self.beenSwiped = false
            self.imageCredit = try container.decode(String.self, forKey: .imageCredit)
            self.readPercent = 0
            self.scrollPosition = 0.0

        }
        
        enum CodingKeys: String, CodingKey { //coding keys for the decoding of JSON objects
            case topicName
            case topicDescription
            case topicInfo
            case category
            case imageURL
            case imageCredit
        }
    
    
}
