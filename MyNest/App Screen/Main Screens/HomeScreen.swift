import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer().frame(height: 40)
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: Logo Circle
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 300, height: 300)
                        
                        Image("myNest_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                    }
                    .padding(.top, 10)
                    
                    // Greeting Text
                    Text("Hello, (name)!")
                        .font(.custom("Kumbh Sans", size: 34).weight(.semibold))
                    
                    Text("What do you want to do today?")
                        .font(.custom("Times New Roman", size: 22).weight(.bold))
                        .foregroundColor(.gray)
                    
                    Spacer().frame(height: 40)
                    
                    // MARK: Action Buttons
                    HStack(alignment: .top, spacing: 18) {
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
                    
                    Spacer(minLength: 87)
                }
                .padding(.horizontal, 25)
            }
            
            BottomNavBar()
        }
        .background(Color.white)
    }
}

// MARK: Reusable Action Button
struct HomeActionButton: View {
    let imageName: String
    let title: String
    let bgColor: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 95, height: 95)

            Text(title)
                .font(.custom("Times New Roman", size: 24))
        }
        .frame(width: 105, height: 115)
        .background(bgColor)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 3)
    }
}

// MARK: Preview
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
