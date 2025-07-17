//
//  ContentView.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 16.07.2025.
//


import SwiftUI

struct ContentView: View {
    
    
    
    @StateObject var myViewModel: MyViewModel = MyViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "iphone")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Login form")
            
            TextField("Enter your login", text: $myViewModel.userLogin)
                .foregroundStyle(Color.blue)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(height: 1)
                }
                .padding(.top, 60)
                .padding(6)
            
            SecureField("Enter your password", text: $myViewModel.userPassword)
            
                .foregroundStyle(Color.blue)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(height: 1)
                }
                .padding(.top, 60)
                .padding(6)
            
            if myViewModel.showAuthError {
                Text("Wrong login or password")
                    .foregroundColor(.red)
                    .transition(.opacity)
            }
            
            Button {
                myViewModel.authorize()
            } label: {
                Text("Log in")
                    .foregroundStyle(Color.black)
                    .font(.title)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.opacity(0.3))
                    }
            }
            .padding(.top, 20)
            
            
        }
        .padding()
        .fullScreenCover(item: $myViewModel.isNextScreenShown) { user in
            MyNewView(user: user)
        }
    }
    
    @ViewBuilder
    private func getNewView() -> some View {
        Text("Hello, World!")
    }
}


#Preview {
    ContentView()
}

#Preview("MyNewView") {
    MyNewView(user: User(login: "login",
                         name: "Name",
                         password: "123123",
                         age: 19,
                         birthday: "15.05.2006",
                         email: "@gmail.com",
                         phone: "+79123456789",
                         biography: "Hello, I know Linked Lists very well!"))
    
}

#Preview("LibraryView") {
    let viewModel = MyViewModel()
    return LibraryView(viewModel: viewModel)
}

#Preview("BookDetailView") {
    let viewModel = MyViewModel()
    let sampleBook = Book(
        title: "Sample Book",
        author: "Sample Author",
        coverImage: "book1",
        description: "This is a sample book description that shows how the detail view will look."
    )
    
    return BookDetailView(book: sampleBook, viewModel: viewModel)
}

#Preview("FavoritesView") {
    let viewModel = MyViewModel()
    viewModel.books[0].isFavorite = true
    viewModel.books[2].isFavorite = true
    
    return FavoritesView(viewModel: viewModel)
}


