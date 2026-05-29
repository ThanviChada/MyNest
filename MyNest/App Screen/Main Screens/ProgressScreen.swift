import SwiftUI

// MARK: - Main Screen
struct ProgressScreen: View {
    
    @State private var goHome = false
    @State private var goSettings = false
    
    // One column for rectangle cards
    private let columns = [
        GridItem(.flexible())
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
                            
                            // Title
                            Text("Progress")
                                .font(.custom("Kumbh Sans", size: 40).weight(.bold))
                                .foregroundColor(primaryBlue)
                                .padding(.top, 20)
                            
                            Text("See your recent donations and requests in one place.")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                                .padding(.bottom, 4)
                            
                            // Donations
                            Text("Your donations")
                                .font(.custom("Kumbh Sans", size: 24).weight(.semibold))
                                .foregroundColor(accentGreen)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                
                                ProgressCard(
                                    type: .donation,
                                    date: "May 27",
                                    item: "Category: Food Dairy - Milk (Qty: 2)",
                                    time: "Pickup • 5–6 PM",
                                    location: "Target Center"
                                )
                            }
                            
                            // Requests
                            Text("Your requests")
                                .font(.custom("Kumbh Sans", size: 24).weight(.semibold))
                                .foregroundColor(accentGreen)
                                .padding(.top, 10)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                
                                ProgressCard(
                                    type: .request,
                                    date: "May 26",
                                    item: """
                                    Category: Clothing
                                    Winter Clothes - Winter Jacket (Qty: 2)
                                    """,
                                    time: "Pickup • Flexible",
                                    location: "Eden Prairie High School"
                                )
                            }
                            
                            Spacer(minLength: 90)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Bottom Navigation
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            goSettings = true
                        } label: {
                            
                            VStack(spacing: 4) {
                                
                                Image(systemName: "gearshape.fill")
                                
                                Text("Settings")
                                    .font(
                                        .custom("Instrument Sans", size: 14)
                                        .weight(.bold)
                                    )
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
                                    .font(
                                        .custom("Instrument Sans", size: 14)
                                        .weight(.bold)
                                    )
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            
                            Image(systemName: "chart.bar.fill")
                            
                            Text("Progress")
                                .font(
                                    .custom("Instrument Sans", size: 14)
                                    .weight(.bold)
                                )
                        }
                        .foregroundColor(darkTabColor)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(
                        color: .black.opacity(0.12),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
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
        case .donation:
            return "Donation"
            
        case .request:
            return "Request"
        }
    }
    
    private var badgeColor: Color {
        switch type {
        case .donation:
            return Color(red: 0.47, green: 0.69, blue: 0.19)
            
        case .request:
            return Color(red: 0.13, green: 0.49, blue: 0.69)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(date)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Text(item)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black.opacity(0.9))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    
                    Text(badgeText)
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
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
            
            Divider()
            
            VStack(alignment: .leading, spacing: 6) {
                
                Label(time, systemImage: "clock")
                
                Label(location, systemImage: "mappin.and.ellipse")
            }
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.gray)
        }
        .padding(18)
        
        // Automatically fits text height
        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
        
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 6,
                    x: 0,
                    y: 4
                )
        )
    }
}

// MARK: - Preview
struct ProgressScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgressScreen()
    }
}
