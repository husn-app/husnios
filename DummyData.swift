let sampleProduct = Product(
    original_website: "Myntra",
    product_url: "https://myntra.com/sarees/mimosa/mimosa-green--gold-toned-art-silk-woven-design-kanjeevaram-saree/13807346/buy",
    product_id: 13807346,
    product_name: "Mimosa Green & Gold-Toned Art Silk Woven Design Kanjeevaram Saree", // Corrected order
    rating: 0.0,
    rating_count: 0,
    brand: "MIMOSA",
    primary_image: "http://assets.myntassets.com/assets/images/13807346/2021/3/23/4c5d5540-931f-4965-bc10-7d08e73cbc7d1616496828268-MIMOSA-Women-Sarees-971616496827362-1.jpg",
    sizes: "Onesize",
    gender: "Women",
    price: 1319.0,
    index : 0,
    inspiration_subcategory: InspirationSubcategory(name: "category", query: "/search/query")
)

// Sample data based on your JSON
let sampleProducts = (0..<100).map { i in
    Product(
        original_website: sampleProduct.original_website,
        product_url: sampleProduct.product_url,
        product_id: sampleProduct.product_id,
        product_name: "product name \(i)",
        rating: sampleProduct.rating,
        rating_count: sampleProduct.rating_count,
        brand: sampleProduct.brand,
        primary_image: sampleProduct.primary_image,
        sizes: sampleProduct.sizes,
        gender: sampleProduct.gender,
        price: sampleProduct.price,
        index: i,
        inspiration_subcategory: InspirationSubcategory(name: "category \(i)", query: "/search/query\(i)")
    )
}

// Sample data based on your JSON
let sampleProducts4 = (0..<4).map { i in
    Product(
        original_website: sampleProduct.original_website,
        product_url: sampleProduct.product_url,
        product_id: sampleProduct.product_id,
        product_name: "product name \(i)",
        rating: sampleProduct.rating,
        rating_count: sampleProduct.rating_count,
        brand: sampleProduct.brand,
        primary_image: sampleProduct.primary_image,
        sizes: sampleProduct.sizes,
        gender: sampleProduct.gender,
        price: sampleProduct.price,
        index: i,
        inspiration_subcategory: InspirationSubcategory(name: "Casual Button Downs \(i)", query: "/search/query\(i)")
    )
}


let sampleProducts6 = (0..<6).map { i in
    Product(
        original_website: sampleProduct.original_website,
        product_url: sampleProduct.product_url,
        product_id: sampleProduct.product_id,
        product_name: "product name \(i)",
        rating: sampleProduct.rating,
        rating_count: sampleProduct.rating_count,
        brand: sampleProduct.brand,
        primary_image: sampleProduct.primary_image,
        sizes: sampleProduct.sizes,
        gender: sampleProduct.gender,
        price: sampleProduct.price,
        index: i,
        inspiration_subcategory: InspirationSubcategory(name: "Casual Button Downs \(i)", query: "/search/query\(i)")
    )
}


let sampleInspiration = Inspiration(
    category: "Smart Casual",
    products: sampleProducts4
)

let sampleInspirations = Array(repeating: sampleInspiration, count: 12)
