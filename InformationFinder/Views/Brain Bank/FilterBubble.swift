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
        if (filterName == "Thumbs Up") {
            Image(systemName: "hand.thumbsup.fill")
                .tint(isSelected ? .darkTan : .darkGreen)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))


        } else if (filterName == "Thumbs Down") {
            Image(systemName: "hand.thumbsdown.fill")
                .tint(isSelected ? .darkTan : .darkGreen)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))



        } else {
            Text(filterName)
                .foregroundColor(isSelected ? .darkTan : .darkGreen)
                .font(.system(size: 15))
                .bold(isSelected)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .darkGreen : .darkTan))
        }
    }
}

#Preview {
    FilterBubble(filterName: "Read", isSelected: true)
}
