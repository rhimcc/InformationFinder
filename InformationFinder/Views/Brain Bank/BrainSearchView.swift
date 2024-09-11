import SwiftUI
import SwiftData

struct BrainSearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @FocusState var searchActive
    @State var showingFilters = false
    @Query private var topics: [Topic]
    @State private var selectedCategories: [String: Bool] = [:]
    var categories: [String] {
        var categories : [String] = []
        for topic in topics {
            if !categories.contains(topic.category) {
                categories.append(topic.category)
            }
        }
        return categories
    }
    

    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "brain")
                    .tint(.darkGreen)
                    .font(.system(size: 25))
                    .padding(.leading, 10)
                    TextField("Search...", text: $searchViewModel.searchQuery)
                    .padding([.top, .bottom, .trailing], 10)
                        .textFieldStyle(.roundedBorder)
                        .focused($searchActive)
                        .onChange(of: searchActive) { value in
                            searchViewModel.isActive = value
                        }
                    
                    if searchActive {
                        Button("Cancel") {
                            searchActive = false
                        }
                        .padding(.trailing, 10)
                    }
                }
          
            }
        
        .background(Color.tan)
        .frame(maxWidth: .infinity, alignment: .leading)
            .edgesIgnoringSafeArea(.bottom)
        }
    }



