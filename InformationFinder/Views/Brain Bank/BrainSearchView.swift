import SwiftUI
import SwiftData

struct BrainSearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @FocusState var searchActive
    @State var showingFilters = false
    @Query private var topics: [Topic]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "brain") // image
                    .tint(.darkGreen)
                    .font(.system(size: 25))
                    .padding(.leading, 10)
                
                    TextField("Search...", text: $searchViewModel.searchQuery) // search field, bound to the search query from the search view model
                    .padding([.top, .bottom, .trailing], 10)
                        .textFieldStyle(.roundedBorder)
                        .focused($searchActive) // sets the active status if the text field has been focused
                        .onChange(of: searchActive) { value in
                            searchViewModel.isActive = value //sets the value of the searchViewModel 'isActive'
                        }
                    
                    if searchActive {
                        Button("Cancel") {
                            searchActive = false
                        }
                        .padding(.trailing, 10)
                    } // allows the user to cancel the search and exit the search result view
                }
          
            }
        
        .background(Color.tan)
        .frame(maxWidth: .infinity, alignment: .leading)
            .edgesIgnoringSafeArea(.bottom)
        }
    }



