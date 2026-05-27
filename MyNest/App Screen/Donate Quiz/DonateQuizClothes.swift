// MARK: - DonateQuizClothes.swift

import SwiftUI

struct DonateQuizClothes: View {
    
    var donationType: String = "Clothes"
    
    @State private var selectedItems: Set<String> = []
    
    let options = [
        "Shirts",
        "Pants",
        "Jackets",
        "Shoes",
        "Sweatshirts",
        "Winter Clothes"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 25) {
                
                Text("What clothes?")
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
                                } else {
                                    selectedItems.insert(option)
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
                        selectedItems: Array(selectedItems)
                    )
                ) {
                    
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedItems.isEmpty
                            ? Color.gray
                            : Color.blue
                        )
                        .cornerRadius(12)
                }
                .disabled(selectedItems.isEmpty)
                .padding()
            }
            .background(
                Color(red: 0.97, green: 0.94, blue: 0.88)
            )
        }
    }
}

#Preview {
    DonateQuizClothes()
}
