import SwiftUI

struct BottomNavbarView: View {
    let selectedTab: String?
    
    var body: some View {
        VStack {
            Spacer()
//            Divider()
            HStack {
                Spacer()
                NavigationLink(destination: MainScreen(selectedTab: Tab.Home)) {
                    Image(systemName: "house")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationLink(destination: MainScreen(selectedTab: Tab.Inspiration)) {
                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationLink(destination: MainScreen(selectedTab: Tab.Wishlist)) {
                    Image(systemName: "heart")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            .background(Color(UIColor.systemBackground))
        }
    }
}


#Preview {
    BottomNavbarView(selectedTab: "feed")
}
