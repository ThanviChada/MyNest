import SwiftUI

struct DonateQuizComplete: View {
    
    var donationType: String
    var selectedItems: [String]
    
    // ✅ ADDED (only change needed)
    @State private var goHome = false
    
    var body: some View {
        ZStack {
            
            // Background color
            Color(red: 0.90, green: 0.96, blue: 0.99)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 25) {
                    
                    Text("Completed!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                        .padding(.top, 40)
                    
                    Text("Your donation has been submitted!")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Order Summary")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color(red: 0.47, green: 0.69, blue: 0.19))
                        
                        Text("Category: \(donationType)")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Text("Items:")
                            .font(.system(size: 18, weight: .semibold))
                        
                        ForEach(selectedItems, id: \.self) { item in
                            Text("• \(item)")
                                .font(.system(size: 16))
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Stay tuned for updates!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                }
                
                // Bottom Nav Bar (UI unchanged)
                HStack {
                    Spacer()
                    
                    Text("Setting")
                    
                    Spacer()
                    
                    Text("Home")
                        .onTapGesture {
                            goHome = true   // ✅ FIXED NAVIGATION
                        }
                    
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
        }
        // ✅ FORCES HOME SCREEN NAVIGATION
        .navigationDestination(isPresented: $goHome) {
            HomeScreen(isNewUser: false)
        }
    }
}

#Preview {
    DonateQuizComplete(
        donationType: "Food",
        selectedItems: ["Protein", "Fruit"]
    )
}
