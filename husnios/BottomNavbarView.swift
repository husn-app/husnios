//
//  BottomNavbarView.swift
//  husnios
//
//  Created by Prashant Shishodia on 19/10/24.
//

import SwiftUI

struct BottomNavbarView: View {
    var body: some View {
        // Bottom navigation bar
        VStack {
            Spacer()
            Divider()
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "house.fill")
                        .font(.title2)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "lightbulb.fill")
                        .font(.title2)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "heart")
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
    BottomNavbarView()
}
