import SwiftUI

struct FindQuizComplete: View {
    
    var requestType: String
    var selectedItems: [String]
    
    @State private var goHome = false
    @State private var goProgress = false
    @State private var goSettings = false
    
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
                    
                    // TOP CARD
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
                        
                        Text("Request Submitted!")
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
                        
                        Text("We’ll help you find what you need")
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
                    
                    
                    // SUMMARY CARD
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text("Request Summary")
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
                            
                            Text(requestType)
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
                            
                            if selectedItems.isEmpty {
                                
                                Text("No items selected")
                                    .foregroundColor(.gray)
                                
                            } else {
                                
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
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    Text("Stay tuned for updates!")
                        .font(
                            .system(
                                size: 16,
                                weight: .semibold
                            )
                        )
                        .foregroundColor(
                            Color(
                                red: 0.13,
                                green: 0.49,
                                blue: 0.69
                            )
                        )
                        .padding(.bottom, 10)
                    
                    
                    // BOTTOM NAV BAR
                    HStack {
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            
                            Image(systemName: "gearshape.fill")
                            
                            Text("Settings")
                                .font(
                                    .custom(
                                        "Instrument Sans",
                                        size: 14
                                    )
                                    .weight(.bold)
                                )
                        }
                        .foregroundColor(
                            Color(
                                red: 0.17,
                                green: 0.60,
                                blue: 0.80
                            )
                        )
                        .onTapGesture {
                            goSettings = true
                        }
                        
                        
                        Spacer()
                        
                        
                        VStack(spacing: 4) {
                            
                            Image(systemName: "house.fill")
                            
                            Text("Home")
                                .font(
                                    .custom(
                                        "Instrument Sans",
                                        size: 14
                                    )
                                    .weight(.bold)
                                )
                        }
                        .foregroundColor(
                            Color(
                                red: 0.04,
                                green: 0.38,
                                blue: 0.57
                            )
                        )
                        .onTapGesture {
                            goHome = true
                        }
                        
                        
                        Spacer()
                        
                        
                        VStack(spacing: 4) {
                            
                            Image(systemName: "chart.bar.fill")
                            
                            Text("Progress")
                                .font(
                                    .custom(
                                        "Instrument Sans",
                                        size: 14
                                    )
                                    .weight(.bold)
                                )
                        }
                        .foregroundColor(
                            Color(
                                red: 0.17,
                                green: 0.60,
                                blue: 0.80
                            )
                        )
                        .onTapGesture {
                            goProgress = true
                        }
                        
                        Spacer()
                    }
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
            
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
            }
        }
    }
}

#Preview {
    FindQuizComplete(
        requestType: "Food",
        selectedItems: [
            "Dairy - Milk (Qty: 2)",
            "Fruit - Apples (Qty: 5)"
        ]
    )
}
