import SwiftUI

struct ProductScreen: View {
    let product_id: Int
    @StateObject private var viewModel = ProductViewModel()
    @State private var isSearchCommited = false
    @State private var searchQuery = ""
    var referrer : String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    SearchBar(text: $searchQuery, isSearchCommited: $isSearchCommited)
                    
                    if (viewModel.product.primary_image.isEmpty) {
                        // Main product occupying full width
                        MainProductView(product: sampleProduct, is_placeholder: true)
                            .frame(maxWidth: .infinity)
                            .redacted(reason: .placeholder)
                    } else {
                        // Main product occupying full width
                        MainProductView(product: viewModel.product)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // Feed of secondary search results
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(Array(viewModel.similarProducts.enumerated()), id: \.element.id) { rank, product in
                            SecondaryProductView(product: product, referrer: "product/product_id=\(product.index)/rank=\(rank)")
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
            }
            .overlay(
                BottomNavbarView(selectedTab : "")
            )
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            viewModel.fetchProductDetails(product_id: product_id, referrer: referrer)
        }
        .background(
            NavigationLink(destination: SearchScreen(query: searchQuery), isActive: $isSearchCommited) {
                EmptyView()
            }
        )
    }
}

#Preview {
    ProductScreen(product_id: 123)
}
