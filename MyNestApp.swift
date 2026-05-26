//
//  MyNestApp.swift
//  MyNest
//
//  Created by 64021960 on 4/7/26.
//

import SwiftUI

@main
struct MyNestApp: App {
    
    @StateObject var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
