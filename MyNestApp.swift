import SwiftUI


struct MyNestApp: App {
    
    @StateObject var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            EntryScreen()
                .environmentObject(authManager)
        }
    }
}
