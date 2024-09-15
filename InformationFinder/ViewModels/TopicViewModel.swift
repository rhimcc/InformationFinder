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
        for topic in topicList {
            if !topic.beenSwiped {
                unswipedTopics.append(topic)
            }
        }
        return unswipedTopics
    }
    
    func getIndexOfTopic(topic: Topic) -> Int? {
        var index: Int = 0
        for checkTopic in topicList {
            if topic.topicName == checkTopic.topicName {
                return index
            } else {
                index+=1
            }
        }
        return nil
    }

        
    
    
    
  
    
    
    
}
