import SwiftUI

enum RequestType: String, CaseIterable {
    case food = "Food"
    case school = "School Supplies"
    case clothing = "Clothing"
    case toys = "Toys"
}

struct FindQuiz1: View {
    
    @State private var selectedOption: RequestType? = nil
    
    @State private var goFood = false
    @State private var goSchool = false
    @State private var goClothing = false
    @State private var goToys = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Text("What are you looking for?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                // Progress bar
                ProgressView(value: 0.1)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                VStack(spacing: 15) {
                    ForEach(RequestType.allCases, id: \.self) { option in
                        
                        HStack {
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
                
                Button("Next") {
                    switch selectedOption {
                    case .food: goFood = true
                    case .school: goSchool = true
                    case .clothing: goClothing = true
                    case .toys: goToys = true
                    default: break
                    }
                }
                .disabled(selectedOption == nil)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedOption == nil ? Color.gray : Color(red: 0.13, green: 0.49, blue: 0.69))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.92, green: 0.94, blue: 0.89))
            
            .navigationDestination(isPresented: $goFood) { FindQuizFood() }
            .navigationDestination(isPresented: $goSchool) { FindQuizSS() }
            .navigationDestination(isPresented: $goClothing) { FindQuizClothes() }
            .navigationDestination(isPresented: $goToys) { FindQuizToys() }
        }
    }
}

struct FindQuiz1_Previews: PreviewProvider {
    static var previews: some View {
        FindQuiz1()
    }
}

