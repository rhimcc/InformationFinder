//
//  ListBaseView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 29/8/2024.
//

import SwiftUI
import SwiftData

struct ListBaseView: View {
    @Query private var brainBank: [Topic]
    @State private var tabSelection = 0
    @State private var thumbsUp = true
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: "brain")
                        .foregroundColor(.darkGreen)
                        .font(.system(size: 50))
                        .padding(.trailing, 20)
                    Text("BRAIN BANK")
                        .font(.title)
                        .bold()
                        .foregroundColor(.darkGreen)
                    
                    
                }
            }.frame(width: UIScreen.main.bounds.width - 40, height: 100)
                .padding([.trailing, .leading], 20)
            
            HStack {
                Spacer()
                
                Button {
                    thumbsUp = true
                    tabSelection = 0
                } label: {
                    Label("", systemImage: tabSelection == 0 ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(.darkGreen)
                }.font(.system(size: 30))
                Spacer()
                Spacer()
                
                Button {
                    thumbsUp = false
                    tabSelection = 1
                } label: {
                    Label("", systemImage: tabSelection == 0 ? "hand.thumbsdown" : "hand.thumbsdown.fill")
                        .foregroundColor(.darkGreen)
                }.font(.system(size: 30))
                Spacer()
                
            }.padding([.top], 20)
            
            TabView(selection: $tabSelection) {
                ThumbsUpView(thumbsedUp: brainBank.filter { $0.thumbsUp })
                    .tabItem{
                    }
                    .tag(0)
                
                ThumbsDownView(thumbsedDown: brainBank.filter { !$0.thumbsUp })
                    .tabItem{
                    }
                    .tag(1)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

#Preview {
    ListBaseView()
}
