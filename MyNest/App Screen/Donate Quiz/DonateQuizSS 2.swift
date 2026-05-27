import SwiftUI

struct DonateQuizSS: View {
    
    var donationType: String = "School Supplies"
    
    @State private var selectedItems: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var itemDetails: [String: String] = [:]
    
    let options = [
        "Notebooks",
        "Pencils",
        "Pens",
        "Backpacks",
        "Folders",
        "Art Supplies"
    ]
    
    // ✅ formatted output for next screen
    var formattedItems: [String] {
        selectedItems.compactMap { option in
            
            let detail = itemDetails[option]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let quantity = quantities[option] ?? 1
            
            return "\(option) - \(detail) (Qty: \(quantity))"
        }
    }
    
    // ✅ NEW: must type something for every selected item
    var canProceed: Bool {
        !selectedItems.isEmpty &&
        selectedItems.allSatisfy { option in
            let text = itemDetails[option]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return !text.isEmpty
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 25) {
                
                Text("What school supplies?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .padding(.top, 40)
                
                ProgressView(value: 0.33)
                    .tint(
                        Color(red: 0.47, green: 0.69, blue: 0.19)
                    )
                    .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(options, id: \.self) { option in
                            
                            VStack(spacing: 12) {
                                
                                HStack {
                                    
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(
                                                selectedItems.contains(option)
                                                ? Color.green
                                                : Color.gray,
                                                lineWidth: 1
                                            )
                                            .frame(width: 20, height: 20)
                                        
                                        if selectedItems.contains(option) {
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color.green)
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    
                                    Text(option)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(
                                            Color(red: 0.13, green: 0.49, blue: 0.69)
                                        )
                                    
                                    Spacer()
                                }
                                
                                if selectedItems.contains(option) {
                                    
                                    TextField(
                                        "Specify supply type...",
                                        text: Binding(
                                            get: { itemDetails[option] ?? "" },
                                            set: { itemDetails[option] = $0 }
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
                                            if let qty = quantities[option], qty > 1 {
                                                quantities[option] = qty - 1
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Text("\(quantities[option] ?? 1)")
                                            .frame(width: 30)
                                            .bold()
                                        
                                        Button {
                                            quantities[option, default: 1] += 1
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(
                                selectedItems.contains(option)
                                ? Color(red: 0.87, green: 0.94, blue: 0.84)
                                : Color.white
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                
                                if selectedItems.contains(option) {
                                    selectedItems.remove(option)
                                    quantities.removeValue(forKey: option)
                                    itemDetails.removeValue(forKey: option)
                                } else {
                                    selectedItems.insert(option)
                                    quantities[option] = 1
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: PickUpLoco(
                        donationType: donationType,
                        selectedItems: formattedItems
                    )
                ) {
                    
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            canProceed ? Color.blue : Color.gray
                        )
                        .cornerRadius(12)
                }
                .disabled(!canProceed)
                .padding()
            }
            .background(
                Color(red: 0.97, green: 0.94, blue: 0.88)
            )
        }
    }
}

#Preview {
    DonateQuizSS()
}
