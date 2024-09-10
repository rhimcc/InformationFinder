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
        HStack {
            TextField("Search...", text: $searchViewModel.searchQuery)
                .padding(10)
                .textFieldStyle(.roundedBorder)
                .focused($searchActive)
                .onChange(of: searchActive) { value in
                    searchViewModel.isActive = value
                }

            if searchActive {
                Button("Cancel") {
                    searchActive = false
                }
                .padding(10)

            } else {
                Button {
                    showingFilters.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .padding(.trailing, 10)
                        .foregroundColor(.darkGreen)
                }
                .sheet(isPresented: $showingFilters) {
                    VStack {
                        Text("Categories:")
                        ForEach(categories, id: \.self) { category in
                            HStack {
                                Button {
//                                    selectedCategories[category]?.toggle()
                                    searchViewModel.selectedCategories[category]?.toggle()
                                    print(searchViewModel.selectedCategories)
                                } label: {
                                    Image(systemName: searchViewModel.selectedCategories[category] ?? true ? "checkmark.square.fill" : "square")
                                }
                                Text("\(category)")
                            }
                        }
                  
                        Button("Close") {
                            showingFilters = false
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            for category in categories {
                searchViewModel.selectedCategories[category] = true
            }
            searchViewModel.applyFilters()
        }
    }
}

