// MARK: - DonateQuizComplete.swift

import SwiftUI

struct DonateQuizComplete: View {
    
    var donationType: String
    var selectedItems: [String]
    var pickupLocation: String
    var pickupTime: String
    
    @State private var goHome = false
    @State private var goProgress = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(
                    red: 0.92,
                    green: 0.94,
                    blue: 0.89
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    VStack(spacing: 12) {
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(
                                Color(
                                    red: 0.47,
                                    green: 0.69,
                                    blue: 0.19
                                )
                            )
                        
                        Text("Donation Submitted!")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(
                                Color(
                                    red: 0.13,
                                    green: 0.49,
                                    blue: 0.69
                                )
                            )
                        
                        Text("Thank you for your donation")
                            .foregroundColor(
                                Color(
                                    red: 1,
                                    green: 0.68,
                                    blue: 0.15
                                )
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text("Donation Summary")
                            .font(
                                .system(
                                    size: 24,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(
                                Color(
                                    red: 0.47,
                                    green: 0.69,
                                    blue: 0.19
                                )
                            )
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Category")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(donationType)
                                .foregroundColor(
                                    Color(
                                        red: 0.13,
                                        green: 0.49,
                                        blue: 0.69
                                    )
                                )
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Items")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            ForEach(selectedItems, id: \.self) { item in
                                
                                Text("• \(item)")
                                    .foregroundColor(
                                        Color(
                                            red: 0.13,
                                            green: 0.49,
                                            blue: 0.69
                                        )
                                    )
                            }
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Pickup Location")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(pickupLocation)
                                .foregroundColor(
                                    Color(
                                        red: 0.13,
                                        green: 0.49,
                                        blue: 0.69
                                    )
                                )
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Pickup Time")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text(pickupTime)
                                .foregroundColor(
                                    Color(
                                        red: 0.13,
                                        green: 0.49,
                                        blue: 0.69
                                    )
                                )
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    DonateQuizComplete(
        donationType: "Food",
        selectedItems: [
            "Dairy - Milk (Qty: 2)",
            "Fruit - Apples (Qty: 5)"
        ],
        pickupLocation: "Community Center",
        pickupTime: "4:00 PM"
    )
}

#Preview {
    DonateQuizComplete(
        donationType: "Food",
        selectedItems: ["Fruit", "Protein"],
        pickupLocation: "Community Center",
        pickupTime: "4:00 PM"
    )
}
