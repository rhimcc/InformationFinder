//
//  Topics.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 30/8/2024.
//

import Foundation
import SwiftData

class Topics {
    @Published var topicList: [Topic] = []

    func loadTopicList(fromName name: String) { // loads the topic list, called when the app is opened
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json") { // gets bundle path, if exists
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: bundlePath)) // gets data from the file
                    let decoder = JSONDecoder()
                    self.topicList = try decoder.decode([Topic].self, from: jsonData) //gets topic list by decoding the data
                    print("Successfully loaded \(topicList.count) topics.") //success message
                } catch {
                    print("Error decoding JSON: \(error)") // error message
                }
            } else {
                print("Failed to find the file in the bundle.") // error message if there is no file in the bundle
            }
        }
}




