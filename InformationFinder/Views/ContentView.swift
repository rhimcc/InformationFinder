//
//  ContentView.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            SearchBaseView()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            SwipeView()
                .tabItem{
                    Label("Swipe", systemImage: "menucard")
                    
                }
                .tag(1)
            
            BrainBankView()
                .tabItem {
                    Label("Brain Bank", systemImage: "brain")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
