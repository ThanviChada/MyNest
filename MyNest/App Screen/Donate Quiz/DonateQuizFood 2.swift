// MARK: - DonateQuizFood.swift

import SwiftUI

struct DonateQuizFood: View {
    
    var donationType: String = "Food"
    
    @State private var selectedFoods: Set<String> = []
    
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
                
                Text("What food?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .padding(.top, 40)
                
                ProgressView(value: 0.33)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(options, id: \.self) { option in
                            
                            HStack {
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(
                                            selectedFoods.contains(option)
                                            ? Color.green
                                            : Color.gray,
                                            lineWidth: 1
                                        )
                                        .frame(width: 20, height: 20)
                                    
                                    if selectedFoods.contains(option) {
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
                            .padding()
                            .background(
                                selectedFoods.contains(option)
                                ? Color(red: 0.87, green: 0.94, blue: 0.84)
                                : Color.white
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                
                                if selectedFoods.contains(option) {
                                    selectedFoods.remove(option)
                                } else {
                                    selectedFoods.insert(option)
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