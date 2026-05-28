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
                
                // Background
                LinearGradient(
                    colors: [
                        Color(red: 0.90, green: 0.93, blue: 0.88),
                        Color(red: 0.85, green: 0.90, blue: 0.84)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer().frame(height: 20)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                            // Logo + greeting
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.94, green: 0.94, blue: 0.96))
                                    .frame(width: 260, height: 260)
                                
                                Image("myNest_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 225)
                            }
                            .padding(.top, 4)
                            
                            VStack(spacing: 4) {
                                Text("Hello, Nestie!")
                                    .font(.custom("Kumbh Sans", size: 34).weight(.semibold))
                                
                                Text("What do you want to do today?")
                                    .font(.custom("Times New Roman", size: 20).weight(.bold))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer().frame(height: 24)
                            
                            // Action buttons
                            HStack(spacing: 14) {
                                
                                HomeActionButton(
                                    imageName: "order",
                                    title: "Request",
                                    bgColor: Color(red: 0.97, green: 0.94, blue: 0.88)
                                )
                                .onTapGesture { goFindQuiz = true }
                                
                                HomeActionButton(
                                    imageName: "donate",
                                    title: "Donate",
                                    bgColor: Color(red: 0.92, green: 0.94, blue: 0.89)
                                )
                                .onTapGesture { goDonateQuiz = true }
                                
                                HomeActionButton(
                                    imageName: "discuss",
                                    title: "Discuss",
                                    bgColor: Color(red: 0.90, green: 0.94, blue: 0.95)
                                )
                                .onTapGesture { goDiscuss = true }
                            }
                            
                            Spacer().frame(height: 80)
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
        VStack(spacing: 6) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 110, height: 130)
        .background(bgColor)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 1)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(isNewUser: false)
    }
}
