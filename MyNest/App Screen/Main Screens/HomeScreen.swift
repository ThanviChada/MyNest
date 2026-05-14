import SwiftUI

struct HomeScreen: View {
    
    // navigation states
    @State private var goFindQuiz = false
    @State private var goDonateQuiz = false
    @State private var goDiscuss = false
    @State private var goHome = false
    @State private var goProgress = false

    // ✅ NEW USER FLAG (from CreateAccount)
    let isNewUser: Bool

    // welcome UI
    @State private var showWelcome = false
    @State private var confetti: [Confetti] = []

    // MARK: - Confetti Model
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

                VStack(spacing: 30) {

                    Spacer().frame(height: 30)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 7) {

                            ZStack {
                                Circle()
                                    .fill(Color(.systemGray6))
                                    .frame(width: 270, height: 270)

                                Image("myNest_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 235)
                            }
                            .padding(.top, 5)

                            Text("Hello, Nestie!")
                                .font(.custom("Kumbh Sans", size: 34).weight(.semibold))
                                .padding(.top, 6)

                            Text("What do you want to do today?")
                                .font(.custom("Times New Roman", size: 22).weight(.bold))
                                .foregroundColor(.gray)

                            Spacer().frame(height: 40)

                            // ✅ YOUR ORIGINAL BUTTONS (UNCHANGED)
                            HStack(spacing: 15) {
                                HomeActionButton(
                                    imageName: "order",
                                    title: "Order",
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

                            Spacer().frame(height: 120)
                        }
                        .padding(.horizontal, 25)
                    }

                    HStack {
                        Spacer()
                        Text("Setting")
                        Spacer()
                        Text("Home")
                        Spacer()
                        Text("Progress")
                        Spacer()
                    }
                    .font(.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                }

                // 🎉 POPUP
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

                // 🎊 CONFETTI
                ForEach(confetti) { piece in
                    Circle()
                        .fill(piece.color)
                        .frame(width: piece.size, height: piece.size)
                        .position(x: piece.x, y: piece.y)
                }
            }

            // NAVIGATION (FIXED)
            .navigationDestination(isPresented: $goFindQuiz) { FindQuiz1() }
            .navigationDestination(isPresented: $goDonateQuiz) { DonateQuiz1() }
            .navigationDestination(isPresented: $goDiscuss) { DiscussionScreen() }
            .navigationDestination(isPresented: $goHome) { HomeScreen(isNewUser: false) }
            .navigationDestination(isPresented: $goProgress) { ProgressScreen() }

            // TRIGGER ONLY FOR NEW USER
            .onAppear {
                if isNewUser {
                    triggerWelcome()
                }
            }
        }
    }

    // MARK: - ANIMATION
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
struct HomeActionButton: View {
    let imageName: String
    let title: String
    let bgColor: Color

    var body: some View {
        VStack(spacing: 1) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(width: 117, height: 117)
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
