import SwiftUI

struct SettingScreen: View {
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Search for Setting")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Settings list
                VStack(spacing: 0) {
                    
                    SettingRow(icon: "person", title: "Account")
                    SettingRow(icon: "bell", title: "Notifications")
                    SettingRow(icon: "lock", title: "Privacy and Security")
                    SettingRow(icon: "headphones", title: "Help and Support")
                    SettingRow(icon: "book", title: "About")
                    SettingRow(icon: "arrow.right.square", title: "Logout")
                    
                }
                .padding(.top, 10)
                
                Spacer()
                
                // Bottom Tab Bar
                BottomTabBar()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    SettingScreen()
}

struct SettingRow: View {
    var icon: String
    var title: String
    
    var body: some View {
        Button {
            // action later
        } label: {
            HStack(spacing: 18) {
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .frame(width: 28)
                    .foregroundColor(.black)
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
        }
        Divider()
    }
}
struct BottomTabBar: View {
    var body: some View {
        HStack {
            Spacer()
            TabItem(icon: "gearshape.fill", title: "Setting")
            Spacer()
            TabItem(icon: "house.fill", title: "Home")
            Spacer()
            TabItem(icon: "chart.bar.fill", title: "Progress")
            Spacer()
        }
        .padding(.vertical, 14)
        .background(Color.white)
        .cornerRadius(18)
        .padding()
        .shadow(radius: 5)
    }
}

struct TabItem: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
            Text(title)
                .font(.system(size: 14, weight: .bold))
        }
        .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
    }
}

