import SwiftUI

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
                        Color.black.opacity(0.2)
                            .ignoresSafeArea()
                        
                        Text("YAY YOU’RE A NESTIE!! 🎉")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .scaleEffect(1.1)
                    }
                }
                
                // Confetti
                ForEach(confetti) { piece in
                    Circle()
                        .fill(piece.color)
                        .frame(width: piece.size, height: piece.size)
                        .position(x: piece.x, y: piece.y)
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
            }
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
            }
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
            }
            
            .onAppear {
                if isNewUser {
                    triggerWelcome()
                }
            }
        }
    }
    
    func triggerWelcome() {
        showWelcome = true
        spawnConfetti()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showWelcome = false
            confetti.removeAll()
        }
    }
    
    func spawnConfetti() {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
        
        for _ in 0..<40 {
            confetti.append(
                Confetti(
                    x: CGFloat.random(in: 0...350),
                    y: -50,
                    color: colors.randomElement()!,
                    size: CGFloat.random(in: 6...10)
                )
            )
        }
        
        withAnimation(.easeIn(duration: 2)) {
            for i in confetti.indices {
                confetti[i].y = 800
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
