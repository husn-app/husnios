//
//  BottomNavbarView.swift
//  husnios
//
//  Created by Prashant Shishodia on 19/10/24.
//

import SwiftUI

struct BottomNavbarView: View {
    let selectedTab: String?
    
    var body: some View {
            VStack {
                Spacer()
                Divider()
                HStack {
                    Spacer()
                    NavigationLink(destination: FeedScreen()) {
                        Image(systemName: selectedTab == "feed" ? "house.fill" : "house")
                            .font(.title2)
                    }
                    Spacer()
                    NavigationLink(destination: InspirationScreen()) {
                        Image(systemName: selectedTab == "inspiration" ? "lightbulb.fill" : "lightbulb")
                            .font(.title2)
                    }
                    Spacer()
                    NavigationLink(destination: InspirationScreen()) {
                        Image(systemName: selectedTab == "favorites" ? "heart.fill" : "heart")
                            .font(.title2)
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
