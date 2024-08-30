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
//    private var stringArray: [[String: Any]] = []

    func loadTopicList(fromName name: String) {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: bundlePath))
                    let decoder = JSONDecoder()
                    self.topicList = try decoder.decode([Topic].self, from: jsonData)
                    print("Successfully loaded \(topicList.count) topics.")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Failed to find the file in the bundle.")
            }
        }
 
}




