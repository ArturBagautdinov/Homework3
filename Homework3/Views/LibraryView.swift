//
//  LibraryView.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 17.07.2025.
//

import SwiftUICore
import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: MyViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.books) { book in
                NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel)) {
                    HStack {
                        Image(book.coverImage)
                            .resizable()
                            .frame(width: 50, height: 70)
                            .cornerRadius(4)
                        
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.author)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if book.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Library")
        }
    }
}
