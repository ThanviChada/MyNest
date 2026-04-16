import SwiftUI

struct EntryScreen: View {
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                // Background image
                Image("myNest_bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .rotationEffect(.degrees(-90))
                
                // Logo
                Image("myNest_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 345)
                    .offset(y: -140)
                
                VStack(spacing: 18) {
                    
                    // GO TO CREATE ACCOUNT
                    NavigationLink(destination: CreateAccount()) {
                        Text("Create Account")
                            .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 287, height: 67)
                            .background(Color(red: 0.17, green:0.537, blue: 0.769))
                            .cornerRadius(15)
                    }
                    
                    //  GO TO SIGN IN
                    NavigationLink(destination: SignInScreen()) {
                        Text("Sign-in")
                            .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 285, height: 60)
                            .background(Color(red: 0.459, green:0.694, blue: 0.184))
                            .cornerRadius(15)
                    }
                }
                .offset(y: 220)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    EntryScreen()
}
