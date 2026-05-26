import SwiftUI

enum DonationType: String, CaseIterable {
    case food = "Food"
    case school = "School Supplies"
    case clothing = "Clothing"
    case toys = "Toys"
}

struct DonateQuiz1: View {
    
    @State private var selectedOption: DonationType? = nil
    
    @State private var goToFood = false
    @State private var goToSchool = false
    @State private var goToClothing = false
    @State private var goToToys = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Text("What are you donating?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                ProgressView(value: 0.1)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                VStack(spacing: 20) {
                    ForEach(DonationType.allCases, id: \.self) { option in
                        
                        Button {
                            selectedOption = option
                        } label: {
                            HStack {
                                Circle()
                                    .stroke(selectedOption == option ? .green : .gray, lineWidth: 2)
                                    .frame(width: 22, height: 22)
                                    .overlay(
                                        Circle().fill(selectedOption == option ? .green : .clear)
                                            .frame(width: 12, height: 12)
                                    )
                                
                                Text(option.rawValue)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                                
                                Spacer()
                            }
                            .padding()
                            .background(selectedOption == option ? Color.green.opacity(0.2) : Color.white)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    switch selectedOption {
                    case .food: goToFood = true
                    case .school: goToSchool = true
                    case .clothing: goToClothing = true
                    case .toys: goToToys = true
                    case .none: break
                    }
                } label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedOption == nil ? .gray : .blue)
                        .cornerRadius(12)
                }
                .disabled(selectedOption == nil)
                .padding()
            }
            .navigationDestination(isPresented: $goToFood) { DonateQuizFood() }
            .navigationDestination(isPresented: $goToSchool) { DonateQuizSchool() }
            .navigationDestination(isPresented: $goToClothing) { DonateQuizClothes() }
            .navigationDestination(isPresented: $goToToys) { DonateQuizToys() }
        }
    }
}

struct DonateQuiz1_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuiz1()
    }
}
