import SwiftUI

struct FeedScreen: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading && viewModel.products.isEmpty {
                VStack {
                    MainProductView(product: sampleProduct, is_embedded_in_feed: true, is_placeholder: true)
                        .redacted(reason: .placeholder)
                        .padding()
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { rank, product in
                            NavigationLink(destination: ProductScreen(product_id: product.index, referrer: "feed/rank=\(rank)")) {
                                MainProductView(product: product, is_embedded_in_feed: true)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .onAppear {
                                        if self.viewModel.shouldLoadMore(rank) {
                                            self.viewModel.fetchMoreFeedProducts()
                                        }
                                    }
                            }
                            Divider()
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    .padding(.bottom, 70)
                }
            }
        }
        .onAppear {
            if viewModel.products.isEmpty {
                viewModel.fetchFeedProducts()
            }
        }
    }
}

#Preview {
    FeedScreen(viewModel: FeedViewModel())
}
