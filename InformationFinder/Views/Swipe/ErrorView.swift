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
        
            RoundedRectangle(cornerRadius: 20)
                .fill(.darkGreen)
                .frame(width: UIScreen.main.bounds.width - 20, height: cardHeight, alignment: .center)
            
            HStack {
                Image(systemName: "brain")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                VStack (alignment: .leading) {
                    Text(text)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(tip)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5) // Shrinks text if needed
                        .multilineTextAlignment(.leading)
                    
                }
         
                
            }
        }
        
    
    }
}

//#Preview {
//    ErrorView()
//}
