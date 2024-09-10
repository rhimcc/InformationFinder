import SwiftUI
import Foundation
import SwiftData

struct ListBaseView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Query private var topics: [Topic]
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
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 100)
            .padding([.trailing, .leading], 20)

            HStack {
                Button("Print topicList") {
                    print(searchViewModel.filteredTopics)
                }
                Spacer()

                Button {
                    thumbsUp = true
                    tabSelection = 0
                } label: {
                    Label("", systemImage: tabSelection == 0 ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(.darkGreen)
                }
                .font(.system(size: 30))
                Spacer()
                Spacer()

                Button {
                    thumbsUp = false
                    tabSelection = 1
                } label: {
                    Label("", systemImage: tabSelection == 1 ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .foregroundColor(.darkGreen)
                }
                .font(.system(size: 30))
                Spacer()

            }
            .padding([.top], 20)

            TabView(selection: $tabSelection) {
                ThumbsUpView(thumbsedUp: searchViewModel.filteredTopics.filter { $0.thumbsUp && $0.beenSwiped })
                    .tabItem{}
                    .tag(0)

                ThumbsDownView(thumbsedDown: searchViewModel.filteredTopics.filter { !$0.thumbsUp && $0.beenSwiped})
                    .tabItem{}
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            searchViewModel.topics = topics
            searchViewModel.applyFilters()
        }
    }
}
