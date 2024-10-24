import SwiftUI

struct WishlistScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(sampleProducts) { product in
                        SecondaryProductView(product: product)
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    WishlistScreen()
}
