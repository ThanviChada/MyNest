import SwiftUI

struct PickUpLoco: View {
    
    var donationType: String = "Pick Up Time and Location"
    
    @State private var selectedItems: Set<String> = []
    @State private var pickupTime = Date()
    
    let options = [
        "Eden Prairie High School",
        "Central Middle School",
        "Oak Point Elementary School",
        "Community Center",
        "Target"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                // Title
                Text("Pick Up Details")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                // Progress Bar
                ProgressView(value: 0.5)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                // Location Options
                VStack(spacing: 15) {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            
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
                
                // Pickup Time
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Pick Up Time")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    
                    DatePicker(
                        "Select Time",
                        selection: $pickupTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 150)
                    .clipped()
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Next Button
                NavigationLink(
                    destination: DonateQuizComplete(
                        donationType: donationType,
                        selectedItems: Array(selectedItems),
               
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
                            : Color(red: 0.13, green: 0.49, blue: 0.69)
                        )
                        .cornerRadius(12)
                }
                .disabled(selectedItems.isEmpty)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.97, green: 0.94, blue: 0.88))
        }
    }
}

struct PickUpLoco_Previews: PreviewProvider {
    static var previews: some View {
        PickUpLoco()
    }
}
