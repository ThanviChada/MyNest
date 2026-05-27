// MARK: - PickUpLoco.swift

import SwiftUI

struct PickUpLoco: View {
    
    var donationType: String
    var selectedItems: [String]
    
    @State private var selectedLocation: String? = nil
    @State private var pickupTime = Date()
    
    let options = [
        "Eden Prairie High School",
        "Central Middle School",
        "Oak Point Elementary School",
        "Community Center",
        "Target"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 25) {
                
                Text("Pick Up Details")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .padding(.top, 40)
                
                ProgressView(value: 0.66)
                    .tint(
                        Color(red: 0.47, green: 0.69, blue: 0.19)
                    )
                    .padding(.horizontal)
                
                VStack(spacing: 15) {
                    
                    ForEach(options, id: \.self) { option in
                        
                        HStack {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(
                                        selectedLocation == option
                                        ? Color.green
                                        : Color.gray,
                                        lineWidth: 1
                                    )
                                    .frame(width: 20, height: 20)
                                
                                if selectedLocation == option {
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.green)
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
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .onTapGesture {
                            selectedLocation = option
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Pick Up Time")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(
                            Color(red: 0.13, green: 0.49, blue: 0.69)
                        )
                    
                    DatePicker(
                        "Select Time",
                        selection: $pickupTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 150)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(
                    destination: DonateQuizComplete(
                        donationType: donationType,
                        selectedItems: selectedItems,
                        pickupLocation: selectedLocation ?? "",
                        pickupTime: pickupTime.formatted(
                            date: .omitted,
                            time: .shortened
                        )
                    )
                ) {
                    
                    Text("Submit")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedLocation == nil
                            ? Color.gray
                            : Color.blue
                        )
                        .cornerRadius(12)
                }
                .disabled(selectedLocation == nil)
                .padding()
            }
            .background(
                Color(red: 0.97, green: 0.94, blue: 0.88)
            )
        }
    }
}

#Preview {
    PickUpLoco(
        donationType: "Food",
        selectedItems: ["Fruit", "Protein"]
    )
}
