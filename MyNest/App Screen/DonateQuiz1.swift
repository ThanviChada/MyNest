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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Text("What are you donating?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                VStack(spacing: 20) {
                    ForEach(DonationType.allCases, id: \.self) { option in
                        HStack {
                            
                            // Checkbox
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                
                                if selectedOption == option {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(red: 0.47, green: 0.69, blue: 0.19))
                                        .frame(width: 20, height: 20)
                                }
                            }
                            
                            Text(option.rawValue)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedOption = option
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    if selectedOption == .food {
                        goToFood = true
                    } else {
                        print("Handle other flows later")
                    }
                }) {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.13, green: 0.49, blue: 0.69))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.92, green: 0.94, blue: 0.89))
            
            // Navigation
            .navigationDestination(isPresented: $goToFood) {
                DonateQuizFood()
            }
        }
    }
}
