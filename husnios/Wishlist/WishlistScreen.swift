import SwiftUI

struct WishlistScreen: View {
    @StateObject private var viewModel = WishlistViewModel()
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.wishlisted_products) { product in
                        SecondaryProductView(product: product)
                    }
                }
                .padding()
            }
        }.onAppear {
            viewModel.fetchWishlistedProducts()
        }
    }
}


#Preview {
    WishlistScreen()
}
