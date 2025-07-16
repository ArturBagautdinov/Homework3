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

struct MyNewView: View {
    @Environment(\.dismiss) var dismiss
    var user: User
    @StateObject var viewModel = MyViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            profileView
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(0)
            
            LibraryView(viewModel: viewModel)
                .tabItem {
                    Label("Library", systemImage: "book")
                }
                .tag(1)
            
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(2)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black)
                    .padding(.trailing, 30)
            }
        }
    }
    
    private var profileView: some View {
        VStack {
            Text("Profile")
            if let avatar = user.avatar {
                Image(avatar)
                    .resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            VStack(spacing: 20) {
                Text(user.name)
                Text("Личная информация")
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Возраст: \(user.age)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Дата рождения: \(user.birthday)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Почта: \(user.email)")
                }
                HStack {
                    Image(systemName: "seal.fill")
                        .imageScale(.small)
                        .foregroundStyle(.blue)
                    Text("Номер телефона: \(user.phone)")
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(1))
                    .frame(width: 200, height: 1)
                
                Text("Биография")
                Text(user.biography)
                    .lineLimit(nil)
                    .fixedSize()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.accentColor.opacity(0.2).ignoresSafeArea()
        }
    }
}

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


