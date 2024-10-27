import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel = SearchViewModel()
    @State var query: String
    @State private var isSearchCommited: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar
            SearchBar(text: $query, isSearchCommited: $isSearchCommited)
            
            // Feed of search results
            if (viewModel.products.isEmpty) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(sampleProducts4) { product in
                        SecondaryProductView(product: product)
                            .foregroundColor(.primary) // Ensure default color for placeholders
                    }
                }
                .redacted(reason: .placeholder)
                .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.products) { product in
                            SecondaryProductView(product: product)
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
            viewModel.fetchProductDetails(query: query)
        }
        .onChange(of: isSearchCommited) { newValue in
            if newValue {
                self.isSearchCommited = false
                viewModel.fetchProductDetails(query: query)
            }
        }
    }
}


#Preview {
    SearchScreen(query : "hello")
}
