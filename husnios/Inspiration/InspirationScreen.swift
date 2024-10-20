import SwiftUI

struct InspirationScreen: View {
    let inspirations = sampleInspirations

    var body: some View {
        NavigationView {
            VStack (spacing: 0){
                TopNavbar()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(inspirations) { inspiration in
                            VStack(alignment: .leading) {
                                Text(inspiration.category)
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(inspiration.subInspirations) { subInspiration in
                                            SubInspirationView(subInspiration: subInspiration)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(height: 220)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .overlay(
                BottomNavbarView(selectedTab: "inspiration")
            )
            .edgesIgnoringSafeArea(.bottom)
        }.navigationBarBackButtonHidden(true)
    }
}

struct SubInspirationView: View {
    let subInspiration: SubInspiration

    var body: some View {
        VStack {
            // Assuming `primary_image` is a URL string
            if let url = URL(string: subInspiration.product.primary_image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    // TODO : Replace with progress views until the output is returned!
                     ProgressView()
                }
                .aspectRatio(3/4, contentMode:.fill)
                .clipped()
                .cornerRadius(8)
            } else {
                // Placeholder for invalid URL
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
            }

            Text(subInspiration.name)
                .font(.subheadline)
                .lineLimit(1)
                .padding(.top, 5)
        }
        .frame(width: 150)
    }
}

#Preview {
    InspirationScreen()
}
