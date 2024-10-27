import SwiftUI

struct SecondaryProductWithoutNavigationView: View {
    let product: Product
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
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
                .padding(.vertical, 4)
                
                // Brand name
                Text(product.brand)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                // Product name after removing brand name.
                Text(product.product_name.replacingOccurrences(of: product.brand, with: "").trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.vertical, 4)
    }
}

struct SecondaryProductView: View {
    let product: Product
    var referrer : String = ""
    
    var body: some View {
        NavigationLink(destination: ProductScreen(product_id: product.index, referrer: referrer)) {
            SecondaryProductWithoutNavigationView(product: product)
        }
    }
}
