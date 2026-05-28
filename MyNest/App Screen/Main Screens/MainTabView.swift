import SwiftUI

enum MainTab {
    case home
    case settings
    case progress
    case discussion
}

struct MainTabView: View {
    
    @State private var selectedTab: MainTab = .home
    
    var body: some View {
        ZStack {
            // Main content switches based on selected tab
            switch selectedTab {
            case .home:
                NavigationStack {
                    HomeScreen(isNewUser: false)
                        .navigationBarBackButtonHidden(true)
                }
            case .settings:
                NavigationStack {
                    SettingScreen()
                        .navigationBarBackButtonHidden(true)
                }
            case .progress:
                NavigationStack {
                    ProgressScreen()
                        .navigationBarBackButtonHidden(true)
                }
            case .discussion:
                NavigationStack {
                    DiscussionScreen()
                        .navigationBarBackButtonHidden(true)
                }
            }
            
            // Shared bottom bar (always on top)
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    BottomBarItem(
                        systemName: "gearshape.fill",
                        title: "Settings",
                        isSelected: selectedTab == .settings
                    ) {
                        selectedTab = .settings
                    }
                    
                    Spacer()
                    
                    BottomBarItem(
                        systemName: "house.fill",
                        title: "Home",
                        isSelected: selectedTab == .home
                    ) {
                        selectedTab = .home
                    }
                    
                    Spacer()
                    
                    BottomBarItem(
                        systemName: "chart.bar.fill",
                        title: "Progress",
                        isSelected: selectedTab == .progress
                    ) {
                        selectedTab = .progress
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
            }
        }
    }
}

struct BottomBarItem: View {
    let systemName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private let primaryBlue = Color(red: 0.13, green: 0.49, blue: 0.69)
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemName)
            Text(title)
                .font(.custom("Instrument Sans", size: 14).weight(.bold))
        }
        .foregroundColor(primaryBlue)
        .padding(.vertical, 4)
        .padding(.horizontal, isSelected ? 6 : 0)
        .background(
            isSelected ?
            RoundedRectangle(cornerRadius: 12)
                .stroke(primaryBlue.opacity(0.25), lineWidth: 1.2)
            : nil
        )
        .onTapGesture {
            action()
        }
    }
}
