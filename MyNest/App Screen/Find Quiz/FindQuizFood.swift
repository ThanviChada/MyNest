import SwiftUI

struct FindQuizFood: View {
    
    @State private var selected: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var itemDetails: [String: String] = [:]
    
    @State private var goNext = false
    
    let options = [
        "Dairy",
        "Protein",
        "Grains",
        "Vegetables",
        "Fruit",
        "Snacks"
    ]
    
    // FORMATTED DATA
    var formattedItems: [String] {
        
        options.compactMap { option in
            
            if selected.contains(option) {
                
                let detail = itemDetails[option] ?? ""
                let quantity = quantities[option] ?? 1
                
                return "\(option) - \(detail) (Qty: \(quantity))"
            }
            
            return nil
        }
    }
    
    // VALIDATION
    var canProceed: Bool {
        !selected.isEmpty &&
        selected.allSatisfy { option in
            let text = itemDetails[option]?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return !text.isEmpty
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 25) {
                
                Text("What food do you need?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .padding(.top, 40)
                
                // Progress Bar
                ProgressView(value: 0.5)
                    .tint(
                        Color(red: 0.47, green: 0.69, blue: 0.19)
                    )
                    .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(options, id: \.self) { option in
                            
                            VStack(spacing: 12) {
                                
                                HStack {
                                    
                                    Image(
                                        systemName:
                                            selected.contains(option)
                                        ? "checkmark.square.fill"
                                        : "square"
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 0.47,
                                            green: 0.69,
                                            blue: 0.19
                                        )
                                    )
                                    
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
                                
                                // EXTRA FIELDS
                                if selected.contains(option) {
                                    
                                    TextField(
                                        "Specify food item...",
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
                                            .foregroundColor(.blue)
                                        }
                                        
                                        Text("\(quantities[option] ?? 1)")
                                            .frame(width: 30)
                                            .bold()
                                        
                                        Button {
                                            
                                            quantities[option, default: 1] += 1
                                            
                                        } label: {
                                            
                                            Image(
                                                systemName:
                                                    "plus.circle.fill"
                                            )
                                            .font(.system(size: 24))
                                            .foregroundColor(.green)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(
                                selected.contains(option)
                                ? Color(
                                    red: 0.87,
                                    green: 0.94,
                                    blue: 0.84
                                )
                                : Color.white
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                
                                if selected.contains(option) {
                                    
                                    selected.remove(option)
                                    quantities.removeValue(forKey: option)
                                    itemDetails.removeValue(forKey: option)
                                    
                                } else {
                                    
                                    selected.insert(option)
                                    quantities[option] = 1
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Button {
                    goNext = true
                } label: {
                    
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            canProceed
                            ? Color(
                                red: 0.13,
                                green: 0.49,
                                blue: 0.69
                            )
                            : Color.gray
                        )
                        .cornerRadius(12)
                }
                .disabled(!canProceed)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(
                Color(red: 0.92, green: 0.94, blue: 0.89)
            )
            
            .navigationDestination(isPresented: $goNext) {
                
                FindQuizComplete(
                    requestType: "Food",
                    selectedItems: formattedItems
                )
            }
        }
    }
}

#Preview {
    FindQuizFood()
}
