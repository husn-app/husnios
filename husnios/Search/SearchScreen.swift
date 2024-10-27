import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel = SearchViewModel()
    @State var query: String
    @State private var isSearchCommited: Bool = false
    @State private var previousQuery: String
    var referrer : String = ""
    
    init(query: String, referrer: String="") {
        self.query = query
        self.referrer = referrer
        self._previousQuery = State(initialValue: query)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar
            SearchBar(text: $query, isSearchCommited: $isSearchCommited)
            
            // Feed of search results
            if (viewModel.products.isEmpty) {
                ScrollView {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(sampleProducts6) { product in
                            SecondaryProductWithoutNavigationView(product: product)
                        }
                    }
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { rank, product in
                            SecondaryProductView(product: product, referrer: "search/query=\(query)/rank=\(rank)")
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
            }
        }
        .overlay(
            BottomNavbarView(selectedTab: "")
        )
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.fetchSearchResults(query: query, referrer: referrer)
        }
        .onChange(of: isSearchCommited) { newValue in
            if newValue {
                self.isSearchCommited = false
                viewModel.fetchSearchResults(query: query, referrer: "search/query=\(previousQuery)")
                previousQuery = query
            }
        }
    }
}


#Preview {
    SearchScreen(query : "hello")
}
