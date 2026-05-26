import SwiftUI

struct DonateQuizClothes: View {
    
    var donationType: String = "Clothes"
    
    @State private var selected: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var details: [String: String] = [:]
    
    let options = ["Casual Wear","Winter Clothing","Athletics","Formal","Essentials"]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Clothing")
                    .font(.title.bold())
                    .padding()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(options, id: \.self) { option in
                            
                            VStack {
                                Text(option)
                                
                                if selected.contains(option) {
                                    TextField("Specify...", text: Binding(
                                        get: { details[option] ?? "" },
                                        set: { details[option] = $0 }
                                    ))
                                    .textFieldStyle(.roundedBorder)
                                    
                                    HStack {
                                        Button("-") {
                                            quantities[option, default: 1] = max(1, quantities[option, default: 1] - 1)
                                        }
                                        Text("\(quantities[option, default: 1])")
                                        Button("+") {
                                            quantities[option, default: 1] += 1
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            .padding()
                            .background(selected.contains(option) ? Color.green.opacity(0.2) : .white)
                            .onTapGesture {
                                if selected.contains(option) {
                                    selected.remove(option)
                                } else {
                                    selected.insert(option)
                                    quantities[option] = 1
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                NavigationLink {
                    DonateQuizComplete(
                        donationType: donationType,
                        selectedItems: selected.map {
                            DonationItem(
                                name: $0,
                                quantity: quantities[$0] ?? 1,
                                details: details[$0]
                            )
                        }
                    )
                } label: {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selected.isEmpty ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
            }
        }
    }
}

struct DonateQuizClothes_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuizClothes()
    }
}
