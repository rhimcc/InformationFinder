//
//  FilterBubble.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 10/9/2024.
//

import SwiftUI

struct FilterBubble: View {
    var filterName: String
    var isSelected: Bool
    var body: some View {
        if (filterName == "Thumbs Up") { // only the thumbs up icon
            Image(systemName: "hand.thumbsup.fill")
                .tint(isSelected ? .darkTan : .darkGreen)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))


        } else if (filterName == "Thumbs Down") { // only the thumbs down icon
            Image(systemName: "hand.thumbsdown.fill")
                .tint(isSelected ? .darkTan : .darkGreen)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))

        } else {
            Text(filterName) // shows the filter name
                .foregroundColor(isSelected ? .darkTan : .darkGreen)
                .font(.system(size: 15))
                .bold()
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))
        }
    }
}

//#Preview {
//    FilterBubble(filterName: "Read", isSelected: true)
//}
