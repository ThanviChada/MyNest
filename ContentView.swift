import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        if authManager.currentUser != nil {
            HomeScreen(isNewUser: authManager.didJustCreateAccount)
        } else {
            EntryScreen()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
