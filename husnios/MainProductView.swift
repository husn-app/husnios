import SwiftUI

struct MainProductView: View {
    var product: Product
    var is_embedded_in_feed : Bool = false
    
    // To make decisions on what to remove in placeholders.
    var is_placeholder: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if (is_embedded_in_feed) {
                BrandIconAndName(product:product).padding(.bottom, 4)
            }
            
            // Product Image with rating overlay
            ZStack(alignment: .bottomTrailing) {
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
                
                if product.rating_count > 0 {
                    HStack(spacing: 4) {
                        RatingView(rating:product.rating, maxRating: 5)
                        Text("(\(product.rating_count))") // Number of reviews
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    .padding(4)
                    .background(Color(UIColor.systemGray).opacity(0.6))
                    .cornerRadius(8)
                    .padding([.bottom, .trailing], 8)
                }
            }
            
            if (!is_placeholder) {
                // Overlay buttons below the image
                MainProductIconTray(product: product)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
            }
            
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
            }
            .padding(.horizontal, 4)
        }
        .background(Color(.systemBackground))
        .padding(.horizontal, 0)
        .padding(.vertical, 16)
    }
}

struct RatingView: View {
    var rating: CGFloat
    var maxRating: Int
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
        }
        
        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.primary)
                }
            }
                .mask(stars)
        )
        .foregroundColor(Color(.systemGray))
        .font(.caption)
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
    var product: Product
    @State private var isLiked: Bool
    @State var showError: Bool = false
    
    // NOTE: setting state this way only works because we ensure that when products don't exist
    // placeholder views are loaded instead. If we remove placeholder views, self._isLiked won't be
    // set in init(). Since this is called once with empty product and latter with the real product
    // after onAppear.
    init(product: Product) {
        self.product = product
        self._isLiked = State(initialValue: product.is_wishlisted)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Spacer()
                Button(action: {
                    toggleWishlistStatus()
                }) {
                    Image(systemName: self.isLiked ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(self.isLiked ? .red : .gray)
                }
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error"), message: Text("Failed to update wishlist status"), dismissButton: .default(Text("OK")))
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
            Spacer()
            VStack {
                Spacer()
                Text("Rs \(product.price, specifier: "%.0f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
    }
    
    func toggleWishlistStatus() {
        getLikedStatusAfterToggle(product_id: product.index) { newStatus in
            if (newStatus == "error") {
                showError = true
            } else {
                isLiked = (newStatus == "true")
            }
        }
    }
}

func getLikedStatusAfterToggle(product_id: Int, completion: @escaping (String) -> Void) {
    let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/wishlist/\(product_id)")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            do {
                if let error = error {
                    print(error)
                    completion("error")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion("error")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let wishlistStatus = json["wishlist_status"] as? Bool {
                        let newStatus: String = wishlistStatus ? "true" : "false"
                        completion(newStatus)
                    } else {
                        completion("error")
                    }
                } catch {
                    print("Failed to parse JSON")
                    print("Data received: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                    completion("error")
                }
            }
        }
    }
    task.resume()
}


#Preview {
    MainProductView(product: sampleProduct)
}
