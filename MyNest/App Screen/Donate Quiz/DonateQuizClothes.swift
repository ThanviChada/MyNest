import SwiftUI

struct DonateQuizClothes: View {
    
    @State private var selectedItems: Set<String> = []
    
    let options = [
        "Casual Wear",
        "Winter Clothing",
        "Athletics",
        "Formal",
        "Essentials/Basics"
    ]
    
    var body: some View {
        VStack(spacing: 25) {
            
            // Title
            Text("What clothing?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                .padding(.top, 40)
            
            // Progress bar
            ProgressView(value: 0.5)
                .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                .padding(.horizontal)
            
            // Options (MULTI-SELECT)
            VStack(spacing: 15) {
                ForEach(options, id: \.self) { option in
                    HStack {
                        
                        // Checkbox
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1)
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
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
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
            
            Spacer()
            
            // Next button
            Button(action: {
                print("Selected clothing: \(selectedItems)")
            }) {
                Text("Next")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        selectedItems.isEmpty
                        ? Color.gray
                        : Color(red: 0.13, green: 0.49, blue: 0.69)
                    )
                    .cornerRadius(12)
            }
            .disabled(selectedItems.isEmpty)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color(red: 0.92, green: 0.94, blue: 0.89))
    }
}

struct DonateQuizClothes_Previews: PreviewProvider {
  static var previews: some View {
      DonateQuizClothes()
  }
}
