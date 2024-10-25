import SwiftUI

struct MainProductView: View {
    var product: Product
    var is_embedded_in_feed : Bool = false
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if (is_embedded_in_feed) {
                BrandIconAndName(product:product).padding(.bottom, 4)
            }
            
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
                .padding(.horizontal, 0)
                .padding(.vertical, 4)
            
            // Product details
            VStack(alignment: .leading, spacing: 0) {
                if (!is_embedded_in_feed) {
                    Text(product.brand)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
                
                Text(product.product_name.replacingOccurrences(of: product.brand, with: "").trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)
                    .lineLimit(1)
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
            .padding(.horizontal, 0)
        }
        .background(Color(.systemBackground))
        .padding(.horizontal, 0)
        .padding(.vertical, 16)
    }
}

struct BrandIconAndName: View {
    let product: Product
    var body: some View {
        HStack {
            if let brandIconURL = URL(string: product.brandIcon), !product.brandIcon.isEmpty {
                AsyncImage(url: brandIconURL) { image in
                    image
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 24, height: 24)
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Text(String(product.brand.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.white)
                    )
            }
            Text("\(product.brand.lowercased().replacingOccurrences(of: "[^a-z0-9]+", with: ".", options: .regularExpression))")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
    }
}

struct MainProductIconTray: View {
    var productID: Int
    @Binding var isLiked: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Spacer()
                Button(action: {
                    isLiked.toggle()
                    toggleWishlist()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(isLiked ? .red : .gray)
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                    // Share action
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                    // M icon action
                }) {
                    Image(systemName: "m.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
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
