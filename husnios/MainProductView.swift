import SwiftUI

struct MainProductView: View {
    var product: Product
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product Image
            AsyncImage(url: URL(string: product.primary_image)) { image in
                image
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(3/4, contentMode: .fill)
                    .clipped()
            }
            
            // Overlay buttons below the image
            MainProductIconTray(productID: product.index, isLiked: $isLiked)
                .padding(.horizontal)
                .padding(.vertical, 8)
            
            // Product details
            VStack(alignment: .leading, spacing: 0) {
                Text(product.brand)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(product.product_name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)
                
                Text("Rs \(product.price, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                // TODO: Replace with product.rating_count > 0 post-testing. 
                if product.rating_count > 0 {
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(product.rating.rounded()) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.subheadline)
                        }
                        Text("(\(product.rating_count))") // Number of reviews
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding()
    }
}

struct MainProductIconTray: View {
    var productID: Int
    @Binding var isLiked: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                isLiked.toggle()
                toggleWishlist()
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
            }
            
            Button(action: {
                // Share action
            }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.primary)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
            }
            
            Button(action: {
                // M icon action
            }) {
                Image(systemName: "m.circle.fill")
                    .foregroundColor(.blue)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
            }
        }
    }
    
    private func toggleWishlist() {
        // TODO: Implement post call to backend.
    }
}

#Preview {
    MainProductView(product: sampleProduct)
}
