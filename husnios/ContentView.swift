//
//  ContentView.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//
import SwiftUI

// Define the Product model
struct Product: Identifiable {
    let id = UUID()
    let original_website: String
    let product_url: String
    let product_id: Int
    let product_name: String
    let rating: Double
    let rating_count: Int
    let brand: String
    let primary_image: String
    let sizes: String
    let gender: String
    let price: Double
    let index: Int
}

// Sample data based on your JSON
let sampleProducts = (0..<100).map { i in
    Product(
        original_website: "Myntra",
        product_url: "https://myntra.com/sarees/mimosa/mimosa-green--gold-toned-art-silk-woven-design-kanjeevaram-saree/13807346/buy",
        product_id: 13807346,
        product_name: "product name \(i)",
        rating: 0.0,
        rating_count: 0,
        brand: "MIMOSA",
        primary_image: "http://assets.myntassets.com/assets/images/13807346/2021/3/23/4c5d5540-931f-4965-bc10-7d08e73cbc7d1616496828268-MIMOSA-Women-Sarees-971616496827362-1.jpg",
        sizes: "Onesize",
        gender: "Women",
        price: 1319.0,
        index: i
    )
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top bar with app title and profile picture
            HStack {
                Text("Husn")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
            }
            .padding()
            
            // Search bar
            SearchBar(text: .constant(""))
                .padding(.horizontal)
            
            // Feed of search results
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(sampleProducts) { product in
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
                .padding()
            }
            .padding(.bottom, 70) // To prevent content from being hidden behind the bottom bar
        }
        .overlay(
            // Bottom navigation bar
            VStack {
                Spacer()
                Divider()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "house.fill")
                            .font(.title2)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                .background(Color(UIColor.systemBackground))
            }
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
