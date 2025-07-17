//
//  FavoritesView.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 17.07.2025.
//

import SwiftUICore
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: MyViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(viewModel.favoriteBooks) { book in
                    VStack {
                        Image(book.coverImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        
                        Text(book.title)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Favorites")
    }
}

