import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer().frame(height: 30)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    
                    // Logo circle (smaller)
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
                    
                    // Buttons row (moved up)
                    HStack(spacing: 14) {
                        
                        HomeActionButton(
                            imageName: "order",
                            title: "Order",
                            bgColor: Color(red: 0.97, green: 0.94, blue: 0.88)
                        )
                        
                        HomeActionButton(
                            imageName: "donate",
                            title: "Donate",
                            bgColor: Color(red: 0.92, green: 0.94, blue: 0.89)
                        )
                        
                        HomeActionButton(
                            imageName: "discuss",
                            title: "Discuss",
                            bgColor: Color(red: 0.90, green: 0.94, blue: 0.95)
                        )
                    }
                    
                    // Space so buttons never hide behind nav bar
                    Spacer().frame(height: 120)
                }
                .padding(.horizontal, 25)
            }
            
            BottomNavBar()
        }
        .background(Color.white)
    }
}

//
// Square Action Button (FIXED)
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
                .frame(width: 100, height: 100)   // adjust size here

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
