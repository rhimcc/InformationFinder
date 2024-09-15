//
//  TopicViewModel.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 30/8/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct TopicViewModel {
    var topicList: [Topic]
    
    func getUnswipedTopics() -> [Topic] {
        var unswipedTopics: [Topic] = []
        for topic in topicList { // goes through each topic that is stored
            if !topic.beenSwiped { //checks if the user has swiped on the topic
                unswipedTopics.append(topic)
            }
        }
        return unswipedTopics // returns array of topics which the user has not swiped
    }
    
    func getIndexOfTopic(topic: Topic) -> Int? { // gets the index of the passed topic
        var index: Int = 0
        for checkTopic in topicList {
            if topic.topicName == checkTopic.topicName {
                return index // returns the index where there is a match for the topic name
            } else {
                index+=1 // increments the index if the topicName is not a match
            }
        }
        return nil
    }

        
    
    
    
  
    
    
    
}
