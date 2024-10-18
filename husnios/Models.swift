import SwiftUI

// Define the Product model
struct Product: Identifiable {
    let id: Int
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

struct SubInspiration {
    let name: String
    let query: String
    let product: Product
}

struct Inspiration {
    let category: String
    let subInspirations: [SubInspiration]
}
