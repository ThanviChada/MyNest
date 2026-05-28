import SwiftUI

// MARK: - Main Screen
struct ProgressScreen: View {
    
    @State private var goHome = false
    @State private var goSettings = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private let primaryBlue = Color(red: 0.13, green: 0.49, blue: 0.69)
    private let accentGreen = Color(red: 0.47, green: 0.69, blue: 0.19)
    
    private let lightTabColor = Color(red: 0.17, green: 0.60, blue: 0.80)
    private let darkTabColor = Color(red: 0.04, green: 0.38, blue: 0.57)
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.93, green: 0.96, blue: 0.90),
                        Color(red: 0.86, green: 0.92, blue: 0.86)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 22) {
                            
                            Text("Progress")
                                .font(.custom("Kumbh Sans", size: 40).weight(.bold))
                                .foregroundColor(primaryBlue)
                                .padding(.top, 20)
                            
                            Text("See your recent donations and requests in one place.")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                                .padding(.bottom, 4)
                            
                            Text("Your donations")
                                .font(.custom("Kumbh Sans", size: 24).weight(.semibold))
                                .foregroundColor(primaryBlue)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ProgressCard(
                                    type: .donation,
                                    date: "May 27",
                                    item: "Groceries box",
                                    time: "Pickup • 5–6 PM",
                                    location: "Eden Prairie, MN"
                                )
                                ProgressCard(
                                    type: .donation,
                                    date: "May 21",
                                    item: "Kids’ clothing",
                                    time: "Drop‑off • 2 PM",
                                    location: "Maple Grove, MN"
                                )
                                ProgressCard(
                                    type: .donation,
                                    date: "May 19",
                                    item: "School supplies",
                                    time: "Pickup • 4 PM",
                                    location: "Online match"
                                )
                            }
                            
                            Text("Your requests")
                                .font(.custom("Kumbh Sans", size: 24).weight(.semibold))
                                .foregroundColor(accentGreen)
                                .padding(.top, 10)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ProgressCard(
                                    type: .request,
                                    date: "May 26",
                                    item: "Warm jackets",
                                    time: "Pickup • Flexible",
                                    location: "Eden Prairie, MN"
                                )
                                ProgressCard(
                                    type: .request,
                                    date: "May 20",
                                    item: "Gently‑used toys",
                                    time: "Drop‑off • Evenings",
                                    location: "Maple Grove, MN"
                                )
                            }
                            
                            Spacer(minLength: 80)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            goSettings = true
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
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
                        
                        VStack(spacing: 4) {
                            Image(systemName: "chart.bar.fill")
                            Text("Progress")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(darkTabColor)
                        
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
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

// MARK: - Reusable Card
struct ProgressCard: View {
    
    enum ProgressType {
        case donation
        case request
    }
    
    var type: ProgressType
    var date: String
    var item: String
    var time: String
    var location: String
    
    private var badgeText: String {
        switch type {
        case .donation: return "Donation"
        case .request: return "Request"
        }
    }
    
    private var badgeColor: Color {
        switch type {
        case .donation: return Color(red: 0.47, green: 0.69, blue: 0.19)
        case .request: return Color(red: 0.13, green: 0.49, blue: 0.69)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(date)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Text(item)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black.opacity(0.9))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text(badgeText)
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(badgeColor.opacity(0.12))
                        .foregroundColor(badgeColor)
                        .cornerRadius(10)
                    
                    Button(action: {
                    }) {
                        Text("Cancel")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.red.opacity(0.8))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Label(time, systemImage: "clock")
                Label(location, systemImage: "mappin.and.ellipse")
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 4)
        )
    }
}

struct ProgressScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProgressScreen()
    }
}
