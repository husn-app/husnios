import SwiftUI

struct WishlistScreen: View {
    @StateObject private var viewModel = WishlistViewModel()
    var body: some View {
        VStack(spacing: 0) {
            // NOTE: DO NOT show placeholder, because wishlist can be really empty.
//            if (viewModel.wishlisted_products.isEmpty) {
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                    ForEach(sampleProducts4) { product in
//                        SecondaryProductView(product: product)
//                    }
//                }.redacted(reason: .placeholder)
//            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.wishlisted_products) { product in
                        SecondaryProductView(product: product, referrer: "wishlist")
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
