import SwiftUI
import UIKit

struct HomeScreen: View {
    
    // navigation states
    @State private var goFindQuiz = false
    @State private var goDonateQuiz = false
    @State private var goDiscuss = false
    @State private var goHome = false
    @State private var goProgress = false
    @State private var goSettings = false
    

    let isNewUser: Bool
    

    @State private var showWelcome = false
    @State private var confetti: [Confetti] = []
    
    struct Confetti: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var color: Color
        var size: CGFloat
        var symbol: String
        var rotation: Angle
        var drift: CGFloat
        var opacity: Double
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.92, green: 0.95, blue: 0.92),
                        Color(red: 0.86, green: 0.91, blue: 0.88),
                        Color(red: 0.82, green: 0.88, blue: 0.86)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                Circle()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: 260, height: 260)
                    .blur(radius: 18)
                    .offset(x: 110, y: -260)

                Circle()
                    .fill(Color(red: 0.83, green: 0.92, blue: 0.89).opacity(0.55))
                    .frame(width: 220, height: 220)
                    .blur(radius: 22)
                    .offset(x: -120, y: 230)
                
                VStack(spacing: 0) {
                    Spacer().frame(height: 14)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 22) {
                            VStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(.white.opacity(0.85))
                                        .frame(width: 272, height: 272)
                                        .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 8)

                                    Circle()
                                        .stroke(Color.white.opacity(0.75), lineWidth: 1)
                                        .frame(width: 250, height: 250)

                                    Image("myNest_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250)
                                        .padding(.leading, 4)
                                }
                                .padding(.top, 6)

                                VStack(spacing: 6) {
                                    Text("Welcome back")
                                        .font(.custom("Instrument Sans", size: 15).weight(.semibold))
                                        .tracking(1.5)
                                        .foregroundColor(Color(red: 0.18, green: 0.34, blue: 0.30).opacity(0.72))

                                    Text("Hello, Nestie!")
                                        .font(.custom("Kumbh Sans", size: 34).weight(.semibold))
                                        .foregroundColor(Color(red: 0.08, green: 0.20, blue: 0.18))

                                    Text("What do you want to do today?")
                                        .font(.custom("Instrument Sans", size: 18).weight(.medium))
                                        .foregroundColor(Color(red: 0.28, green: 0.38, blue: 0.36))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)

                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 12) {
                                    HomeActionButton(
                                        imageName: "order",
                                        title: "Request",
                                        bgColor: Color.white.opacity(0.92)
                                    )
                                    .onTapGesture { goFindQuiz = true }

                                    HomeActionButton(
                                        imageName: "donate",
                                        title: "Donate",
                                        bgColor: Color.white.opacity(0.92)
                                    )
                                    .onTapGesture { goDonateQuiz = true }

                                    HomeActionButton(
                                        imageName: "discuss",
                                        title: "Discuss",
                                        bgColor: Color.white.opacity(0.92)
                                    )
                                    .onTapGesture { goDiscuss = true }
                                }
                            }
                            .padding(18)
                            .background(.white.opacity(0.45))
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                            .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 10)

                            Spacer().frame(height: 62)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Bottom Navigation Bar (matches Settings style)
                    HStack {
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                        .onTapGesture {
                            goSettings = true
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "house.fill")
                            Text("Home")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(Color(red: 0.04, green: 0.38, blue: 0.57)) // slightly darker to indicate current
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "chart.bar.fill")
                            Text("Progress")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                        .onTapGesture {
                            goProgress = true
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                }
                
                // Welcome overlay
                if showWelcome {
                    ZStack {
                        Color.black.opacity(0.16)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(red: 0.98, green: 0.78, blue: 0.42))

                            Text("Yay, you're a Nestie!")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.30, green: 0.17, blue: 0.11))
                        }
                        .padding(.horizontal, 26)
                        .padding(.vertical, 18)
                        .background(.white.opacity(0.94))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 8)
                        .offset(y: showWelcome ? -120 : -160)
                        .opacity(showWelcome ? 1 : 0)
                        .animation(.spring(response: 0.45, dampingFraction: 0.88), value: showWelcome)
                    }
                }
                
                // Confetti
                ForEach(confetti) { piece in
                    Image(systemName: piece.symbol)
                        .font(.system(size: piece.size, weight: .bold))
                        .foregroundStyle(piece.color)
                        .opacity(piece.opacity)
                        .position(x: piece.x, y: piece.y)
                        .rotationEffect(piece.rotation)
                        .shadow(color: .white.opacity(0.45), radius: 1, x: 0, y: 0)
                }
            }
            
            // Navigation destinations
            .navigationDestination(isPresented: $goFindQuiz) {
                FindQuiz1()
            }
            .navigationDestination(isPresented: $goDonateQuiz) {
                DonateQuiz1()
            }
            .navigationDestination(isPresented: $goDiscuss) {
                DiscussionScreen()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
                    .navigationBarBackButtonHidden(true)
            }
            
            .onAppear {
                if isNewUser {
                    triggerWelcome()
                }
            }
        }
    }
    
    func triggerWelcome() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.88)) {
            showWelcome = true
        }
        spawnConfetti()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation(.easeOut(duration: 0.22)) {
                showWelcome = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                confetti.removeAll()
            }
        }
    }
    
    func spawnConfetti() {
        let colors: [Color] = [
            Color(red: 0.99, green: 0.75, blue: 0.84),
            Color(red: 0.76, green: 0.90, blue: 0.99),
            Color(red: 0.82, green: 0.95, blue: 0.86),
            Color(red: 0.99, green: 0.88, blue: 0.64),
            Color(red: 0.90, green: 0.84, blue: 0.99),
            Color(red: 0.99, green: 0.83, blue: 0.73),
            Color(red: 0.96, green: 0.92, blue: 0.66)
        ]
        let symbols = ["heart.fill", "star.fill", "circle.fill", "sparkles", "moon.stars.fill"]
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<110 {
            confetti.append(
                Confetti(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: -240 ... -60),
                    color: colors.randomElement() ?? .blue,
                    size: CGFloat.random(in: 5...10),
                    symbol: symbols.randomElement() ?? "circle.fill",
                    rotation: .degrees(Double.random(in: 0...360)),
                    drift: CGFloat.random(in: -42...42),
                    opacity: Double.random(in: 0.82...1.0)
                )
            )
        }
        
        withAnimation(.easeOut(duration: 2.0)) {
            for i in confetti.indices {
                confetti[i].y = screenHeight + 80
                confetti[i].x += confetti[i].drift
                confetti[i].rotation = .degrees(Double.random(in: 180...480))
            }
        }
    }
}

// MARK: - HomeActionButton

struct HomeActionButton: View {
    let imageName: String
    let title: String
    let subtitle: String?
    let bgColor: Color
    
    init(imageName: String, title: String, subtitle: String? = nil, bgColor: Color) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.bgColor = bgColor
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 104, height: 104)
                .padding(.top, 2)
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.14, green: 0.23, blue: 0.22))
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 138)
        .background(bgColor)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 4)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(isNewUser: false)
    }
}
