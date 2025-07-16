//
//  MyViewModel.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 16.07.2025.
//

import SwiftUI

struct User: Identifiable {
    var id: UUID = UUID()
    var login: String
    var name: String
    var password: String
    var age: Int
    var birthday: String
    var email: String
    var phone: String
    var biography: String
    var avatar: String?
}

struct Book: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var author: String
    var coverImage: String
    var description: String
    var isFavorite: Bool = false
}


class MyViewModel: ObservableObject {
    @Published var userLogin: String = ""
    @Published var userPassword: String = ""
    @Published var showAuthError = false
    @Published var isNextScreenShown: User?
    
    var users: [User] = [.init(login: "Arbuzzz3",
                               name: "Artur",
                               password: "123456",
                               age: 19,
                               birthday: "22.05.2006",
                               email: "artur@gmail.com",
                               phone: "+79123456789",
                               biography: "Hello, Im Java Spring Developer!",
                               avatar: "profile1Image"),
                         .init(login: "Tom23",
                               name: "Tom",
                               password: "123123",
                               age: 22,
                               birthday: "19.07.2002",
                               email: "tom@gmail.com",
                               phone: "+79123456789",
                               biography: "Hello, Im SwiftUI Developer!",
                               avatar: "profileImage"),
                         .init(login: "Abcd123",
                               name: "John",
                               password: "12312",
                               age: 22,
                               birthday: "19.07.2002",
                               email: "john@gmail.com",
                               phone: "+79123456789",
                               biography: "Hello, I know C# not bad!")]
    
    
    @Published var books: [Book] = [
        Book(title: "SwiftUI Essentials",
             author: "John Doe",
             coverImage: "book1",
             description: "Learn SwiftUI from scratch"),
        Book(title: "Advanced Swift",
             author: "Jane Smith",
             coverImage: "book2",
             description: "Master advanced Swift concepts"),
        Book(title: "Design Patterns",
             author: "Robert Martin",
             coverImage: "book3",
             description: "Classic design patterns in Swift"),
        Book(title: "Clean Code",
             author: "Uncle Bob",
             coverImage: "book4",
             description: "Writing maintainable code"),
        Book(title: "Algorithms",
             author: "Donald Knuth",
             coverImage: "book5",
             description: "Fundamental algorithms")
    ]
    
    
    func authorize() {
        for user in users {
            if userLogin == user.login && userPassword == user.password {
                isNextScreenShown = user
                showAuthError = false
                return
            }
        }
        showAuthError = true
    }
    
    func toggleFavorite(for book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isFavorite.toggle()
        }
    }
    
    var favoriteBooks: [Book] {
        books.filter { $0.isFavorite }
    }
}


