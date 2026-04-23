import SwiftUI

struct FindQuizSS: View {
    
    @State private var selected: Set<String> = []
    @State private var goNext = false
    
    let options = ["Notebooks", "Pencils", "Pens", "Backpacks", "Folders", "Art Supplies"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Text("What school supplies do you need?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .padding(.top, 40)
                
                // Progress bar
                ProgressView(value: 0.5)
                    .tint(Color(red: 0.47, green: 0.69, blue: 0.19))
                    .padding(.horizontal)
                
                VStack(spacing: 15) {
                    ForEach(options, id: \.self) { option in
                        
                        HStack {
                            Image(systemName: selected.contains(option) ? "checkmark.square.fill" : "square")
                                .foregroundColor(Color(red: 0.47, green: 0.69, blue: 0.19))
                            
                            Text(option)
                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            if selected.contains(option) {
                                selected.remove(option)
                            } else {
                                selected.insert(option)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    goNext = true
                } label: {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selected.isEmpty ? Color.gray : Color(red: 0.13, green: 0.49, blue: 0.69))
                        .cornerRadius(12)
                }
                .disabled(selected.isEmpty)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.92, green: 0.94, blue: 0.89))
            
            .navigationDestination(isPresented: $goNext) {
                FindQuizComplete(
                    requestType: "School Supplies",
                    selectedItems: Array(selected)
                )
            }
        }
    }
}

struct FindQuizSS_Previews: PreviewProvider {
    static var previews: some View {
        FindQuizSS()
    }
}
