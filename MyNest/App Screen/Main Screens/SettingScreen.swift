import SwiftUI

struct SettingScreen: View {
    
    @State private var goHome = false
    @State private var goProgress = false
    @State private var goAccount = false
    @State private var showAboutCard = false
    
    private let lightTabColor = Color(red: 0.17, green: 0.60, blue: 0.80)
    private let darkTabColor = Color(red: 0.04, green: 0.38, blue: 0.57)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.92, green: 0.94, blue: 0.89)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Text("Settings")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        SettingRow(
                            icon: "person.fill",
                            title: "Account & Preferences"
                        )
                        .onTapGesture {
                            goAccount = true
                        }
                        
                        SettingRow(
                            icon: "heart.text.square.fill",
                            title: "About MyNest"
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showAboutCard.toggle()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    
                    if showAboutCard {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("About MyNest")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color(red: 0.47, green: 0.69, blue: 0.19))
                            
                            Text("MyNest is a community donation hub where people can request support and offer what they have to share, all in one simple place.")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Label(
                                    "Request essentials like food, clothing, toys, and school supplies",
                                    systemImage: "heart.fill"
                                )
                                
                                Label(
                                    "Donate through short quizzes that match you with meaningful requests",
                                    systemImage: "checkmark.circle.fill"
                                )
                                
                                Label(
                                    "Browse the discussion board to see offers, needs, and community updates",
                                    systemImage: "bubble.left.and.bubble.right.fill"
                                )
                                
                                Label(
                                    "Track your giving and requests on the progress screen",
                                    systemImage: "chart.bar.fill"
                                )
                            }
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(18)
                        .padding(.horizontal)
                        .padding(.top, 30)
                        .shadow(
                            color: Color.black.opacity(0.05),
                            radius: 4,
                            x: 0,
                            y: 3
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(darkTabColor)
                        
                        Spacer()
                        
                        Button {
                            goHome = true
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: "house.fill")
                                Text("Home")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button {
                            goProgress = true
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: "chart.bar.fill")
                                Text("Progress")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goAccount) {
                Text("Account & Preferences Screen")
            }
        }
    }
}

#Preview {
    SettingScreen()
}

// MARK: - Setting Row
struct SettingRow: View {
    
    var icon: String
    var title: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .frame(width: 28)
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(
            color: Color.black.opacity(0.04),
            radius: 3,
            x: 0,
            y: 2
        )
    }
}
