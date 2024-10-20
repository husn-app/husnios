//
//  SearchView.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//

import SwiftUI

struct WishlistScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            TopNavbar()
            
            // Feed of search results
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(sampleProducts) { product in
                        SecondaryProductView(product: product)
                    }
                }
                .padding()
            }
            .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
        }
        .overlay(
            BottomNavbarView(selectedTab: "")
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    WishlistScreen()
}
