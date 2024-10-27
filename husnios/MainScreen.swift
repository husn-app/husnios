import SwiftUI

enum Tab: String {
    case Home
    case Inspiration
    case Wishlist
}

struct MainScreen: View {
    @State var selectedTab: Tab = Tab.Home
    @State private var isSearchCommited = false
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopNavbar()
                SearchBar(text: $searchQuery, isSearchCommited: $isSearchCommited)
                
                TabView(selection: $selectedTab) {
                    FeedScreen()                        .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tab.Home)
                    
                    InspirationScreen()
                        .tabItem {
                            Image(systemName: "sparkles")
                            Text("Inspiration")
                        }
                        .tag(Tab.Inspiration)
                    
                    WishlistScreen()
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Wishlist")
                        }
                        .tag(Tab.Wishlist)
                }
                .accentColor(.primary)
            }
            .background(
                NavigationLink(destination: SearchScreen(query: searchQuery, referrer:"\(selectedTab)"), isActive: $isSearchCommited) {
                    EmptyView()
                }
            )
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainScreen()
}
