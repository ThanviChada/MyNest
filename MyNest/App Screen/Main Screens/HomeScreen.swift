import SwiftUI

struct HomeScreen: View {
    
    // navigation states
    @State private var goFindQuiz = false
    @State private var goDonateQuiz = false
    @State private var goDiscuss = false
    
    // ✅ ADDED (for bottom nav)
    @State private var goHome = false
    @State private var goProgress = false
    
    var body: some View {
        
        NavigationStack {
        
            VStack(spacing: 30) {
                
                Spacer().frame(height: 30)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 7) {
                        
                        // Logo circle
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
                        
                        // Greeting
                        Text("Hello, (name)!")
                            .font(.custom("Kumbh Sans", size: 34).weight(.semibold))
                            .padding(.top, 6)
                        
                        Text("What do you want to do today?")
                            .font(.custom("Times New Roman", size: 22).weight(.bold))
                            .foregroundColor(.gray)
                        
                        Spacer().frame(height: 40)
                        
                        // Buttons row
                        HStack(spacing: 15) {
                            
                            HomeActionButton(
                                imageName: "order",
                                title: "Order",
                                bgColor: Color(red: 0.97, green: 0.94, blue: 0.88)
                            )
                            .onTapGesture {
                                goFindQuiz = true
                            }
                            
                            HomeActionButton(
                                imageName: "donate",
                                title: "Donate",
                                bgColor: Color(red: 0.92, green: 0.94, blue: 0.89)
                            )
                            .onTapGesture {
                                goDonateQuiz = true
                            }
                            
                            HomeActionButton(
                                imageName: "discuss",
                                title: "Discuss",
                                bgColor: Color(red: 0.90, green: 0.94, blue: 0.95)
                            )
                            .onTapGesture {
                                goDiscuss = true
                            }
                        }
                        
                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal, 25)
                }
                
                // 🔧 UPDATED NAV BAR (minimal edits only inside)
                HStack {
                    Spacer()
                    
                    Text("Setting")
                    
                    Spacer()
                    
                    Text("Home")
                        .onTapGesture {
                            goHome = true   // ✅ HOME NAVIGATION
                        }
                    
                    Spacer()
                    
                    Text("Progress")
                        .onTapGesture {
                            goProgress = true   // ✅ PROGRESS NAVIGATION
                        }
                    
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
            .background(Color.white)
            
            // navigation destinations
            .navigationDestination(isPresented: $goFindQuiz) {
                FindQuiz1()
            }
            .navigationDestination(isPresented: $goDonateQuiz) {
                DonateQuiz1()
            }
            .navigationDestination(isPresented: $goDiscuss) {
                DiscussionScreen()
            }
            
            // ✅ ADDED
            .navigationDestination(isPresented: $goHome) {
                HomeScreen()
            }
            
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
            }
        }
    }
}

//
// Square Action Button (UNCHANGED)
//
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
        HomeScreen()
    }
}
