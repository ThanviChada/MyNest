import SwiftUI

struct DonateQuizFood: View {
    
    var donationType: String = "Food"
    
    @State private var selectedFoods: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var itemDetails: [String: String] = [:]
    
    let options = [
        "Dairy",
        "Protein",
        "Grains",
        "Vegetables",
        "Fruit",
        "Snacks"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 25) {
                
                // Title
                Text("What food?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .padding(.top, 40)
                
                // Progress Bar
                ProgressView(value: 0.33)
                    .tint(
                        Color(red: 0.47, green: 0.69, blue: 0.19)
                    )
                    .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(options, id: \.self) { option in
                            
                            VStack(spacing: 12) {
                                
                                // Main Row
                                HStack {
                                    
                                    // Checkbox
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(
                                                selectedFoods.contains(option)
                                                ? Color(
                                                    red: 0.47,
                                                    green: 0.69,
                                                    blue: 0.19
                                                )
                                                : Color.gray,
                                                lineWidth: 1
                                            )
                                            .frame(width: 20, height: 20)
                                        
                                        if selectedFoods.contains(option) {
                                            
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(
                                                    Color(
                                                        red: 0.47,
                                                        green: 0.69,
                                                        blue: 0.19
                                                    )
                                                )
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    
                                    Text(option)
                                        .font(
                                            .system(
                                                size: 20,
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
                                    
                                    Spacer()
                                }
                                
                                
                                // Dropdown Section
                                if selectedFoods.contains(option) {
                                    
                                    VStack(spacing: 12) {
                                        
                                        // Item Description
                                        TextField(
                                            "Specify item type...",
                                            text: Binding(
                                                get: {
                                                    itemDetails[option] ?? ""
                                                },
                                                set: {
                                                    itemDetails[option] = $0
                                                }
                                            )
                                        )
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        
                                        
                                        // Quantity
                                        HStack {
                                            
                                            Text("Quantity")
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                            
                                            Button {
                                                
                                                if let qty = quantities[option],
                                                   qty > 1 {
                                                    quantities[option] = qty - 1
                                                }
                                                
                                            } label: {
                                                
                                                Image(
                                                    systemName:
                                                        "minus.circle.fill"
                                                )
                                                .font(.system(size: 24))
                                                .foregroundColor(
                                                    Color(
                                                        red: 0.13,
                                                        green: 0.49,
                                                        blue: 0.69
                                                    )
                                                )
                                            }
                                            
                                            
                                            Text(
                                                "\(quantities[option] ?? 1)"
                                            )
                                            .frame(width: 30)
                                            .bold()
                                            
                                            
                                            Button {
                                                
                                                quantities[
                                                    option,
                                                    default: 1
                                                ] += 1
                                                
                                            } label: {
                                                
                                                Image(
                                                    systemName:
                                                        "plus.circle.fill"
                                                )
                                                .font(.system(size: 24))
                                                .foregroundColor(
                                                    Color(
                                                        red: 0.47,
                                                        green: 0.69,
                                                        blue: 0.19
                                                    )
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(
                                selectedFoods.contains(option)
                                ? Color(
                                    red: 0.87,
                                    green: 0.94,
                                    blue: 0.84
                                )
                                : Color.white
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                
                                if selectedFoods.contains(option) {
                                    
                                    selectedFoods.remove(option)
                                    quantities.removeValue(forKey: option)
                                    itemDetails.removeValue(forKey: option)
                                    
                                } else {
                                    
                                    selectedFoods.insert(option)
                                    quantities[option] = 1
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Next Button
                NavigationLink(
                    destination: PickUpLoco(
                        donationType: donationType,
                        selectedItems: Array(selectedFoods)
                    )
                ) {
                    
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedFoods.isEmpty
                            ? Color.gray
                            : Color.blue
                        )
                        .cornerRadius(12)
                }
                .disabled(selectedFoods.isEmpty)
                .padding()
            }
            .background(
                Color(red: 0.97, green: 0.94, blue: 0.88)
            )
        }
    }
}

#Preview {
    DonateQuizFood()
}
