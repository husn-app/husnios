//
//  SearchView.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopNavbar()
            
            // Search bar
            SearchBar(text: .constant(""))
            
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
            BottomNavbarView()
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SecondaryProductView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Product image
            AsyncImage(url: URL(string: product.primary_image)) { image in
                image
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(3/4, contentMode: .fill)
            }
            .cornerRadius(10)
            
            // Brand name
            Text(product.brand)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
            
            // Product name
            Text(product.product_name)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
    }
}

#Preview {
    SearchView()
}
