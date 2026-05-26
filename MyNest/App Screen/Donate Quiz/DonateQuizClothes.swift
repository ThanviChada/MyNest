import SwiftUI

struct DonateQuizClothes: View {
    
    var donationType: String = "Clothes"
    
    @State private var selectedItems: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var itemDetails: [String: String] = [:]
    
    @State private var otherSelected = false
    @State private var otherText = ""
    @State private var otherQuantity = 1
    
    let options = [
        "Casual Wear",
        "Winter Clothing",
        "Athletics",
        "Formal",
        "Essentials/Basics"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Text("What clothing?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                ProgressView(value: 0.5)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
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
                                                ? Color(red: 0.47, green: 0.69, blue: 0.19)
                                                : Color.gray,
                                                lineWidth: 1
                                            )
                                            .frame(width: 20, height: 20)
                                        
                                        if selectedItems.contains(option) {
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color(red: 0.47, green: 0.69, blue: 0.19))
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    
                                    Text(option)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                                    
                                    Spacer()
                                }
                                
                                if selectedItems.contains(option) {
                                    
                                    TextField("Specify item...", text: Binding(
                                        get: { itemDetails[option] ?? "" },
                                        set: { itemDetails[option] = $0 }
                                    ))
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
                                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                                        }
                                        
                                        Text("\(quantities[option] ?? 1)")
                                            .frame(width: 30)
                                            .bold()
                                        
                                        Button {
                                            quantities[option, default: 1] += 1
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(Color(red: 0.47, green: 0.69, blue: 0.19))
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
                            .cornerRadius(10)
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
                        
                        // OTHER
                        VStack(spacing: 12) {
                            
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(
                                            otherSelected ? Color.green : Color.gray,
                                            lineWidth: 1
                                        )
                                        .frame(width: 20, height: 20)
                                    
                                    if otherSelected {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.green)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                
                                Text("Other")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                                
                                Spacer()
                            }
                            
                            if otherSelected {
                                TextField("Type clothing item...", text: $otherText)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                
                                HStack {
                                    Text("Quantity")
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                    Button {
                                        if otherQuantity > 1 { otherQuantity -= 1 }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                    }
                                    
                                    Text("\(otherQuantity)")
                                        .frame(width: 30)
                                        .bold()
                                    
                                    Button {
                                        otherQuantity += 1
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(otherSelected ? Color(red: 0.87, green: 0.94, blue: 0.84) : Color.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            otherSelected.toggle()
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: DonateQuizComplete(
                        donationType: donationType,
                        selectedItems: Array(selectedItems)
                    )
                ) {
                    Text("Finish")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedItems.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(12)
                }
                .disabled(selectedItems.isEmpty)
                .padding()
            }
            .background(Color(red: 0.92, green: 0.94, blue: 0.89))
        }
    }
}

struct DonateQuizClothes_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuizClothes()
    }
}
