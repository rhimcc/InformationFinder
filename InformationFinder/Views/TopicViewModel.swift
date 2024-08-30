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
    
    var unswipedTopics: [Topic] {
        var unswipedTopics: [Topic] = []
        for topic in topicList {
            if !topic.beenSwiped {
                unswipedTopics.append(topic)
            }
        }
        return unswipedTopics
    }

        
    
    
    
  
    
    
    
}
