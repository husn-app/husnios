import SwiftUI

struct FeedScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            TopNavbar()
            SearchBar(text: .constant(""))
            
            ScrollView {
                VStack(spacing: 0) {
                    // Display all products as MainProductView
                    ForEach(sampleProducts) { product in
                        MainProductView(product: product)
                            .frame(maxWidth: .infinity)
                    }
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
    FeedScreen()
}
