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

    init(
        original_website: String = "",
        product_url: String = "",
        product_id: Int = 0,
        product_name: String = "",
        rating: Double = 0.0,
        rating_count: Int = 0,
        brand: String = "",
        primary_image: String = "",
        sizes: String = "",
        gender: String = "",
        price: Double = 0.0,
        index: Int = 0
    ) {
        self.id = index
        self.original_website = original_website
        self.product_url = product_url
        self.product_id = product_id
        self.product_name = product_name
        self.rating = rating
        self.rating_count = rating_count
        self.brand = brand
        self.primary_image = primary_image
        self.sizes = sizes
        self.gender = gender
        self.price = price
        self.index = index
    }
}

struct SubInspiration: Identifiable {
    let id: UUID
    let name: String
    let query: String
    let product: Product

    init(
        id: UUID = UUID(),
        name: String = "",
        query: String = "",
        product: Product = Product()
    ) {
        self.id = id
        self.name = name
        self.query = query
        self.product = product
    }
}

struct Inspiration: Identifiable {
    let id: UUID
    let category: String
    let subInspirations: [SubInspiration]

    init(
        id: UUID = UUID(),
        category: String = "",
        subInspirations: [SubInspiration] = []
    ) {
        self.id = id
        self.category = category
        self.subInspirations = subInspirations
    }
}
