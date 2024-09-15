//
//  ErrorView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 12/9/2024.
//

import SwiftUI

struct ErrorView: View {
    var text: String
    var cardHeight: CGFloat = 100
    var tip: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20) // background rectangle
                .fill(.darkGreen)
                .frame(width: UIScreen.main.bounds.width - 20, height: cardHeight, alignment: .center)
            HStack {
                Image(systemName: "brain") // image
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                VStack (alignment: .leading) {
                    Text(text) // text with key problem
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(tip) // text with advice for how to resolve the problem
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                    
                }
         
                
            }
        }
        
    
    }
}

//#Preview {
//    ErrorView()
//}
