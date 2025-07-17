//
//  BookDetailView.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 17.07.2025.
//

import SwiftUICore
import SwiftUI

struct BookDetailView: View {
    let book: Book
    @ObservedObject var viewModel: MyViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(book.coverImage)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(book.title)
                .font(.title)
            
            Text("by \(book.author)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(book.description)
                .padding()
            
            Button {
                viewModel.toggleFavorite(for: book)
            } label: {
                Label(
                    book.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                    systemImage: book.isFavorite ? "heart.fill" : "heart"
                )
                .foregroundColor(book.isFavorite ? .red : .blue)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Book Details")
    }
}
