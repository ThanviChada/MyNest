import SwiftUI

struct EntryScreen: View {
    var body: some View {
        ZStack {
            // Background image
            Image("myNest_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .rotationEffect(.degrees(-90))
            
            // Logo image
            Image("myNest_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 345)
                .offset(y: -140)
            
            // Buttons stack
            VStack(spacing: 18) {
                // Create Account button
                Button(action: {
                    print("Create Account tapped")
                }) {
                    Text("Create Account").fontWeight(.bold)
                        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 287, height: 67)
                        .background(Color(red: 0.17, green:0.537, blue: 0.769 ).opacity(100))
                        .cornerRadius(15)
                }

                // Sign-in button
                Button(action: {
                    print("Sign-in tapped")
                }) {
                    Text("Sign-in")
                        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 285, height: 60)
                        .background(Color(red: 0.459, green:0.694, blue: 0.184).opacity(100))
                        .cornerRadius(15)
                }
            }
            .offset(y: 220) // Adjust vertical placement to match your design
        }
        .frame(width: 403, height: 900)
        .background(.white)
        .cornerRadius(3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryScreen()
    }
}
