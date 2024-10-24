import SwiftUI

struct ProductScreen: View {
    let product_id: Int
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    SearchBar(text: .constant(""), isSearchCommited: .constant(false))
                    
                    // Main product occupying full width
                    MainProductView(product: viewModel.product)
                        .frame(maxWidth: .infinity)
                    
                    // Feed of secondary search results
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.similarProducts) { product in
                            SecondaryProductView(product: product)
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
            viewModel.fetchProductDetails(product_id: product_id)
        }
    }
}

#Preview {
    ProductScreen(product_id: 123)
}
