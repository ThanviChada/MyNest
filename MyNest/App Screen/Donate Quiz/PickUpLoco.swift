// MARK: - PickUpLoco.swift

import SwiftUI

struct PickUpLoco: View {
    
    var donationType: String
    var selectedItems: [String]
    
    @State private var selectedLocation: String? = nil
    @State private var pickupDate = Date()
    
    let options = [
        "Eden Prairie High School",
        "Central Middle School",
        "Oak Point Elementary School",
        "Community Center",
        "Target"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                Color(red: 0.97, green: 0.94, blue: 0.88)
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 28) {
                        
                        // Title
                        VStack(spacing: 12) {
                            
                            Text("Pick Up Details")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(
                                    Color(
                                        red: 0.13,
                                        green: 0.49,
                                        blue: 0.69
                                    )
                                )
                            
                            ProgressView(value: 0.66)
                                .tint(
                                    Color(
                                        red: 0.47,
                                        green: 0.69,
                                        blue: 0.19
                                    )
                                )
                                .padding(.horizontal, 10)
                        }
                        .padding(.top, 30)
                        
                        // Location Section
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text("Select Pick Up Location")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(
                                    Color(
                                        red: 0.13,
                                        green: 0.49,
                                        blue: 0.69
                                    )
                                )
                            
                            VStack(spacing: 14) {
                                
                                ForEach(options, id: \.self) { option in
                                    
                                    HStack(spacing: 15) {
                                        
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(
                                                    selectedLocation == option
                                                    ? Color.green
                                                    : Color.gray,
                                                    lineWidth: 2
                                                )
                                                .frame(width: 22, height: 22)
                                            
                                            if selectedLocation == option {
                                                
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.green)
                                                    .frame(width: 22, height: 22)
                                            }
                                        }
                                        
                                        Text(option)
                                            .font(
                                                .system(
                                                    size: 18,
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
                                    .cornerRadius(16)
                                    .shadow(
                                        color: .black.opacity(0.04),
                                        radius: 3,
                                        x: 0,
                                        y: 2
                                    )
                                    .onTapGesture {
                                        selectedLocation = option
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text("Pick Up Date & Time")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(
                                    Color(red: 0.13, green: 0.49, blue: 0.69)
                                )
                            
                            ZStack(alignment: .leading) {
                                
                                DatePicker(
                                    "",
                                    selection: $pickupDate,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                if Calendar.current.isDateInToday(pickupDate) {
                                   
                                
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(
                                color: .black.opacity(0.04),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                        }
                    
                        .padding(.horizontal)
                        // Submit Button
                        NavigationLink(
                            destination: DonateQuizComplete(
                                donationType: donationType,
                                selectedItems: selectedItems,
                                pickupLocation: selectedLocation ?? "",
                                pickupTime: pickupDate.formatted(
                                    date: .abbreviated,
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
                                .cornerRadius(16)
                        }
                        .disabled(selectedLocation == nil)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    PickUpLoco(
        donationType: "Food",
        selectedItems: ["Fruit", "Protein"]
    )
}
