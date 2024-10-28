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
    @StateObject private var feedViewModel = FeedViewModel()
    @StateObject private var inspirationViewModel = InspirationViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopNavbar()
                SearchBar(text: $searchQuery, isSearchCommited: $isSearchCommited)
                
                TabView(selection: $selectedTab) {
                    FeedScreen(viewModel: feedViewModel)
                        .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tab.Home)
                    
                    InspirationScreen(viewModel: inspirationViewModel)
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
                .onChange(of: selectedTab) { newTab in
                    if newTab == .Home {
                        feedViewModel.products = []
                    } else if newTab == .Inspiration {
                        inspirationViewModel.inspirations = []
                    }
                }
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
