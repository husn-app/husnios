import SwiftUI

struct InspirationSubcategory: Identifiable {
    let id: UUID
    let name: String
    let query: String
    
    init(id: UUID = UUID(), name: String = "", query: String = "") {
        self.id = id
        self.name = name
        self.query = query
    }
    
    init(json: [String: Any]) {
        self.id = UUID()
        self.name = json["name"] as? String ?? ""
        self.query = json["query"] as? String ?? ""
    }
}

// Define the Product model
struct Product: Identifiable {
    let id: UUID = UUID()
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
    let inspiration_subcategory: InspirationSubcategory
    
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
        index: Int = 0,
        inspiration_subcategory: InspirationSubcategory = InspirationSubcategory()
    ) {
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
        self.inspiration_subcategory = inspiration_subcategory
    }
    
    init(json: [String: Any]) {
        self.original_website = json["original_website"] as? String ?? ""
        self.product_url = json["product_url"] as? String ?? ""
        self.product_id = json["product_id"] as? Int ?? 0
        self.product_name = json["product_name"] as? String ?? ""
        self.rating = json["rating"] as? Double ?? 0.0
        self.rating_count = json["rating_count"] as? Int ?? 0
        self.brand = json["brand"] as? String ?? ""
        self.primary_image = json["primary_image"] as? String ?? ""
        self.sizes = json["sizes"] as? String ?? ""
        self.gender = json["gender"] as? String ?? ""
        self.price = json["price"] as? Double ?? 0.0
        self.index = json["index"] as? Int ?? 0
        if let subcategoryJson = json["inspiration_subcategory"] as? [String: Any] {
            self.inspiration_subcategory = InspirationSubcategory(json: subcategoryJson)
        } else {
            self.inspiration_subcategory = InspirationSubcategory()
        }
    }
}

struct Inspiration: Identifiable {
    let id: String
    let category: String
    let products: [Product]
    
    init(category: String = "", products: [Product] = []) {
        self.id = category
        self.category = category
        self.products = products
    }
    
    init(json: [String: Any]) {
        self.id = json["category"] as? String ?? ""
        self.category = json["category"] as? String ?? ""
        if let productsJson = json["products"] as? [[String: Any]] {
            self.products = productsJson.map { Product(json: $0) }
        } else {
            self.products = []
        }
    }
}
