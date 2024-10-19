import SwiftUI

struct ProductScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            TopNavbar()
            SearchBar(text: .constant(""))
            
            ScrollView {
                VStack(spacing: 0) {
                    // Main product occupying full width
                    if let mainProduct = sampleProducts.first {
                        MainProductView(product: mainProduct)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // Feed of secondary search results
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(sampleProducts.dropFirst()) { product in
                            SecondaryProductView(product: product)
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
            }
            .overlay(
                BottomNavbarView()
            )
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}




#Preview {
    ProductScreen()
}


