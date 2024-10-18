//
//  SearchModelView.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//


// Sample data based on your JSON
let sampleProducts = (0..<100).map { i in
    Product(
        id: i,
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
