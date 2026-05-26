import SwiftUI

struct DonateQuizFood: View {
    
    var donationType: String = "Food"
    
    @State private var selected: Set<String> = []
    @State private var quantities: [String: Int] = [:]
    @State private var details: [String: String] = [:]
    
    let options = ["Dairy", "Protein", "Grains", "Vegetables", "Fruit", "Snacks"]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("What food?")
                    .font(.title.bold())
                    .foregroundColor(Color.blue)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 12) {
                        
                        ForEach(options, id: \.self) { option in
                            
                            VStack(spacing: 10) {
                                
                                HStack {
                                    Text(option)
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                if selected.contains(option) {
                                    
                                    TextField("Specify...", text: Binding(
                                        get: { details[option] ?? "" },
                                        set: { details[option] = $0 }
                                    ))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
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
                            .background(selected.contains(option) ? Color.green.opacity(0.2) : Color.white)
                            .cornerRadius(10)
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
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected.isEmpty ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(selected.isEmpty)
                .padding()
            }
        }
    }
}

struct DonateQuizFood_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuizFood()
    }
}
