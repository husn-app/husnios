import SwiftUI

struct InspirationScreen: View {
    @StateObject private var viewModel = InspirationViewModel()
    
    var body: some View {
        VStack (spacing: 0){
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach($viewModel.inspirations, id: \.id) { $inspiration in
                        VStack(alignment: .leading) {
                            Text(inspiration.category)
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(inspiration.products) { product in
                                        SubInspirationView(product: product)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        Divider()
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            viewModel.fetchInspirations()
            // viewModel.inspirations = sampleInspirations
        }
    }
}

struct SubInspirationView: View {
    let product: Product
    
    var body: some View {
        VStack {
            // Assuming `primary_image` is a URL string
            if let url = URL(string: product.primary_image) {
                NavigationLink(destination: SearchScreen(query: product.inspiration_subcategory.query)) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 280, height: 372)
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        // TODO : Replace with progress views until the output is returned!
                        ProgressView()
                            .frame(width: 280, height: 372)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .clipped()
                    .cornerRadius(8)
                }
            } else {
                // Placeholder for invalid URL
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 372)
                    .foregroundColor(.gray)
            }
            
            Text(product.inspiration_subcategory.name)
                .font(.subheadline)
                .lineLimit(1)
                .padding(.top, 5)
        }
        .frame(width: 280)
    }
}

#Preview {
    InspirationScreen()
}
