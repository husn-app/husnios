import SwiftUI

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
