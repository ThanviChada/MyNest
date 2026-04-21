import SwiftUI

// MARK: - Main Screen
struct ProgressScreen: View {
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top white bar (status area)
            Color.white
                .frame(height: 40)
                .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    
                    // TITLE
                    Text("Progress")
                        .font(.custom("Kumbh Sans", size: 48).weight(.bold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                        .padding(.top, 10)
                    
                    // MARK: Donations Section
                    Text("Your donations")
                        .font(.custom("Kumbh Sans", size: 28).weight(.semibold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ProgressCard()
                        ProgressCard()
                        ProgressCard()
                    }
                    
                    // MARK: Orders Section
                    Text("Your orders")
                        .font(.custom("Kumbh Sans", size: 28).weight(.semibold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                        .padding(.top, 6)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ProgressCard()
                        ProgressCard()
                    }
                    
                    Spacer(minLength: 80)
                }
                .padding(.horizontal, 20)
            }
            
            BottomNavBar()
        }
        .background(Color(red: 0.92, green: 0.94, blue: 0.89))
    }
}

//
// MARK: - Reusable Card
//
struct ProgressCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .top) {
                Text("Date")
                    .font(.custom("Instrument Sans", size: 15).weight(.semibold))
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Cancel")
                        .font(.custom("Instrument Sans", size: 13).weight(.bold))
                    Text("Contact")
                        .font(.custom("Josefin Sans", size: 12).weight(.bold))
                }
            }
            
            Text("Item")
            Text("Pick-up time")
            Text("Location")
        }
        .font(.custom("Instrument Sans", size: 13).weight(.semibold))
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 4)
    }
}

//
// MARK: - Bottom Navigation Bar
//
struct BottomNavBar: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Setting")
            Spacer()
            Text("Home")
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

//
// MARK: - Preview
//
struct ProgressScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProgressScreen()
    }
}
