import SwiftUI

struct FeedScreen: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.products.isEmpty {
                VStack() {
                    MainProductView(product:sampleProduct, is_embedded_in_feed: true, is_placeholder: true)
                        .redacted(reason: .placeholder)
                        .padding()
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        // Display all products as MainProductView
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductScreen(product_id: product.index)) {
                                MainProductView(product: product, is_embedded_in_feed: true)
                                    .frame(maxWidth: .infinity)
                            }
                            Divider()
                        }
                    }
                    .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
                }
            }
        }
        .onAppear {
            viewModel.fetchFeedProducts()
            // viewModel.products = sampleProducts
        }
    }
}

#Preview {
    FeedScreen()
}
