import SwiftUI

struct DonateQuizComplete: View {
    
    // Data passed from quiz
    var donationType: String
    var selectedItems: [String]
    var pickupLocation: String
    var pickupTime: String
    
    @State private var goHome = false
    @State private var goProgress = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                Color(red: 0.92, green: 0.94, blue: 0.89)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Success Card
                    VStack(spacing: 12) {
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(
                                Color(red: 0.47, green: 0.69, blue: 0.19)
                            )
                        
                        Text("Donation Submitted!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(
                                Color(red: 0.13, green: 0.49, blue: 0.69)
                            )
                        
                        Text("Thank you for your donation")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(
                                Color(red: 1, green: 0.68, blue: 0.15)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    
                    // Donation Summary Card
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text("Donation Summary")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(
                                Color(red: 0.47, green: 0.69, blue: 0.19)
                            )
                        
                        
                        // Category
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Category")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(donationType)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(
                                    Color(red: 0.13, green: 0.49, blue: 0.69)
                                )
                        }
                        
                        
                        // Items
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Items")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            if selectedItems.isEmpty {
                                Text("No items selected")
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(selectedItems, id: \.self) { item in
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 7))
                                        
                                        Text(item)
                                    }
                                    .foregroundColor(
                                        Color(red: 0.13, green: 0.49, blue: 0.69)
                                    )
                                }
                            }
                        }
                        
                        
                        // Pickup Location
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Pickup Location")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(pickupLocation)
                                .foregroundColor(
                                    Color(red: 0.13, green: 0.49, blue: 0.69)
                                )
                        }
                        
                        
                        // Pickup Time
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Pickup Time")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(pickupTime)
                                .foregroundColor(
                                    Color(red: 0.13, green: 0.49, blue: 0.69)
                                )
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    Text("Stay tuned for updates!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(
                            Color(red: 0.13, green: 0.49, blue: 0.69)
                        )
                    
                    
                    // Bottom Navigation
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
            .navigationBarBackButtonHidden(true)
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
    DonateQuizComplete(
        donationType: "Food",
        selectedItems: ["Dairy", "Fruit"],
        pickupLocation: "Eden Prairie Community Center",
        pickupTime: "May 30 • 4:00 PM"
    )
}
