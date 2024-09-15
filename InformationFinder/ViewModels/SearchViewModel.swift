import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchQuery = "" //stores searchQuery which is manipulated in both SearchView and BrainSearchView
    @Published var isActive = false //stores active state which is manipulated in both SearchView and BrainSearchView
    }

