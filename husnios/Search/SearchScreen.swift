//
//  SearchView.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel = SearchViewModel()
    var query : String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar
            SearchBar(text: .constant(query))
            
            // Feed of search results
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.products) { product in
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
        .onAppear {
            viewModel.fetchProductDetails(query: query)
        }
    }
}


#Preview {
    SearchScreen()
}
