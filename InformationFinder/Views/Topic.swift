//
//  Topic.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import Foundation

class Topic {
    var topicName: String
    var isFavourited: Bool
    var imageURL: String
    
    init(topicName: String, isFavourited: Bool, imageURL: String){
        self.topicName = topicName
        self.isFavourited = isFavourited
        self.imageURL = imageURL
    }
}
