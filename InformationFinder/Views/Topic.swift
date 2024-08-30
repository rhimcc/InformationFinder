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
    var wordCount: Int {
        let components = self.topicInfo.components(separatedBy: .whitespacesAndNewlines)
        let wordCount = components.count
        return wordCount
    }
    
    var calculatedTime: Int {
        let time = (Double(wordCount) / 250.0).rounded()
        return Int(time)
    }
    
    init(topicName: String, topicDescription: String, topicInfo: String, category: String, imageURL: String){
        self.topicName = topicName
        self.topicDescription = topicDescription
        self.topicInfo = topicInfo
        self.imageURL = imageURL
        self.beenSwiped = false
        self.thumbsUp = false
        self.category = category
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.topicName = try container.decode(String.self, forKey: .topicName)
            self.topicDescription = try container.decode(String.self, forKey: .topicDescription)
            self.topicInfo = try container.decode(String.self, forKey: .topicInfo)
            self.category = try container.decode(String.self, forKey: .category)
            self.imageURL = try container.decode(String.self, forKey: .imageURL)
            self.thumbsUp = false
            self.beenSwiped = false
        }
        
        // Define coding keys that map to the JSON keys
        enum CodingKeys: String, CodingKey {
            case topicName
            case topicDescription
            case topicInfo
            case category
            case imageURL
        }
    
    
}
