import SwiftUI

struct DonateQuizComplete: View {
    
    var donationType: String
    var selectedItems: [String]
    
    var body: some View {
        VStack {
            
            VStack(spacing: 25) {
                
                Text("Completed!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                Text("Your donation has been submitted!")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color.orange)
                
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
            
            // Bottom Bar
            HStack {
                VStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                Spacer()
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
                Spacer()
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
            .padding()
            .background(Color.white)
        }
        .background(Color(red: 0.90, green: 0.94, blue: 0.95))
    }
}

struct DonateQuizComplete_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuizComplete(
            donationType: "Food",
            selectedItems: ["Protein", "Fruit"]
        )
    }
}
