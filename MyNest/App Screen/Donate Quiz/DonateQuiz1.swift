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
                
                // Progress bar
                ProgressView(value: 0.1)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                VStack(spacing: 20) {
                    ForEach(DonationType.allCases, id: \.self) { option in
                        
                        Button(action: {
                            selectedOption = option
                        }) {
                            HStack {
                                
                                ZStack {
                                    Circle()
                                        .stroke(
                                            selectedOption == option
                                            ? Color(red: 0.47, green: 0.69, blue: 0.19)
                                            : Color.gray,
                                            lineWidth: 2
                                        )
                                        .frame(width: 24, height: 24)
                                    
                                    if selectedOption == option {
                                        Circle()
                                            .fill(Color(red: 0.47, green: 0.69, blue: 0.19))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                                
                                Text(option.rawValue)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                                
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedOption == option
                                ? Color(red: 0.87, green: 0.94, blue: 0.84)
                                : Color.white
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        selectedOption == option
                                        ? Color(red: 0.47, green: 0.69, blue: 0.19)
                                        : Color.clear,
                                        lineWidth: 2
                                    )
                            )
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    switch selectedOption {
                    case .food:
                        goToFood = true
                    case .school:
                        goToSchool = true
                    case .clothing:
                        goToClothing = true
                    case .toys:
                        goToToys = true
                    case .none:
                        break
                    }
                }) {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedOption == nil
                            ? Color.gray
                            : Color(red: 0.13, green: 0.49, blue: 0.69)
                        )
                        .cornerRadius(12)
                }
                .disabled(selectedOption == nil)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.92, green: 0.94, blue: 0.89))
            
            // Navigation
            .navigationDestination(isPresented: $goToFood) {
                DonateQuizFood()
            }
            .navigationDestination(isPresented: $goToSchool) {
                DonateQuizSS()
            }
            .navigationDestination(isPresented: $goToClothing) {
                DonateQuizClothes()
            }
            .navigationDestination(isPresented: $goToToys) {
                DonateQuizToys()
            }
        }
    }
}

struct DonateQuiz1_Previews: PreviewProvider {
    static var previews: some View {
        DonateQuiz1()
    }
}
