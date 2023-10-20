//
//  FavCryptApp.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 4.10.2023.
//

import SwiftUI

@main
struct FavCryptApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                EmptyView()
                    .tabItem {
                        Label("Test", systemImage: "square.and.pencil")
                    }
            }
        }
    }
}
