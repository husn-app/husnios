//
//  TopNavbar.swift
//  husnios
//
//  Created by Prashant Shishodia on 19/10/24.
//
import SwiftUI

struct TopNavbar: View {
    var body: some View {
        
        // Top bar with app title and profile picture
        HStack {
            Text("Husn")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
        }
        .padding(.top, 0)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}
