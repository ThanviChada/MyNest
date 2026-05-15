import SwiftUI

struct FindQuizComplete: View {
    
    var requestType: String
    var selectedItems: [String]
    
    @State private var goHome = false
    @State private var goProgress = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                Color(red: 0.92, green: 0.94, blue: 0.89)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Top card
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 200)
                            .cornerRadius(10)
                        
                        VStack(spacing: 10) {
                            
                            Text("Request Submitted!")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(
                                    Color(red: 0.13, green: 0.49, blue: 0.69)
                                )
                            
                            Text("We’ll help you find what you need")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(
                                    Color(red: 1, green: 0.68, blue: 0.15)
                                )
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)
                    
                    // Order summary
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Order Summary")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(
                                Color(red: 0.47, green: 0.69, blue: 0.19)
                            )
                        
                        Text("Category: \(requestType)")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(
                                Color(red: 0.13, green: 0.49, blue: 0.69)
                            )
                        
                        Text("Items:")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(
                                Color(red: 0.13, green: 0.49, blue: 0.69)
                            )
                        
                        if selectedItems.isEmpty {
                            Text("No items selected")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(selectedItems, id: \.self) { item in
                                Text("• \(item)")
                                    .foregroundColor(
                                        Color(red: 0.13, green: 0.49, blue: 0.69)
                                    )
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Stay tuned for updates!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(
                            Color(red: 0.13, green: 0.49, blue: 0.69)
                        )
                        .padding(.bottom, 30)
                    
                    // Navigation bar
                    HStack {
                        Spacer()
                        
                        Text("Settings")
                        
                        Spacer()
                        
                        Text("Home")
                            .onTapGesture {
                                goHome = true
                            }
                        
                        Spacer()
                        
                        Text("Progress")
                            .onTapGesture {
                                goProgress = true
                            }
                        
                        Spacer()
                    }
                    .font(.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(
                        Color(red: 0.17, green: 0.60, blue: 0.80)
                    )
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                }
            }
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
            }
        }
    }
}

#Preview {
    FindQuizComplete(
        requestType: "Food",
        selectedItems: ["Protein", "Fruit"]
    )
}
