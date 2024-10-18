import SwiftUI

struct MainProductView: View {
    var product: Product
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product Image with overlay buttons
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.primary_image)) { image in
                    image
                        .resizable()
                        .aspectRatio(3/4, contentMode: .fill)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 300)
                }
                
                // Overlay buttons
                VStack(spacing: 10) {
                    Button(action: {
                        isLiked.toggle()
                        toggleWishlist()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        // Share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        // M icon action
                    }) {
                        Image(systemName: "m.circle.fill")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
            
            // Product details
            VStack(alignment: .leading, spacing: 8) {
                Text(product.product_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(product.rating.rounded()) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.subheadline)
                    }
                    Text("(\(Int(product.rating * 20)))") // Example: Number of reviews
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding()
    }
    
    private func toggleWishlist() {
        // TODO: Implement post call to backend.
    }
}
