import SwiftUI


struct MyNestApp: App {
    
    @StateObject var authManager = AuthManager()
    
    init() {
        FirebaseBootstrap.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EntryScreen()
                .environmentObject(authManager)
        }
    }
}
