//
//  MyNewView.swift
//  Homework3
//
//  Created by Artur Bagautdinov on 17.07.2025.
//

import SwiftUICore
import SwiftUI

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
