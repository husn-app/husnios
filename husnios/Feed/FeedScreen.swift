import SwiftUI

struct FeedScreen: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopNavbar()
                SearchBar(text: .constant(""))
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Display all products as MainProductView
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductScreen(product_id: product.index)) {
                                MainProductView(product: product)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
                }
            }
            .overlay(
                BottomNavbarView(selectedTab: "feed")
            )
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchFeedProducts()
            // viewModel.products = sampleProducts
        }
    }
}

#Preview {
    FeedScreen()
}
