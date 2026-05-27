import SwiftUI

struct PhoneNumScreen: View {
    
    let fullName: String
    let username: String
    let password: String
    
    @EnvironmentObject var authManager: AuthManager
    
    @State private var phoneNumber = ""
    @State private var goToVerification = false
    
    @StateObject var otpManager = OTPManager()
    
    var digitsOnly: String {
        phoneNumber.filter { $0.isNumber }
    }
    
    var formValid: Bool {
        digitsOnly.count >= 10
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(red: 0.17, green: 0.65, blue: 0.84)
                    .opacity(0.08)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    Text("Enter your mobile number")
                        .font(.custom("Instrument Sans", size: 30).weight(.bold))
                        .foregroundColor(
                            Color(red: 0.49, green: 0.22, blue: 0.13)
                        )
                    
                    Text("We’ll send a verification code on this number")
                        .font(.custom("Instrument Sans", size: 17).weight(.bold))
                        .foregroundColor(
                            Color(red: 0.54, green: 0.49, blue: 0.49)
                        )
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                    
                    if !phoneNumber.isEmpty && !formValid {
                        
                        Text("Enter a valid phone number")
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    Button("Next") {
                        
                        otpManager.sendOTP(to: digitsOnly)
                        
                        goToVerification = true
                    }
                    .font(
                        .custom("Instrument Sans", size: 22)
                        .weight(.bold)
                    )
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        formValid
                        ? Color.green
                        : Color.gray
                    )
                    .cornerRadius(18)
                    .disabled(!formValid)
                }
                .padding(28)
            }
            
            .navigationDestination(isPresented: $goToVerification) {
                
                VerificationScreen(
                    fullName: fullName,
                    username: username,
                    password: password,
                    phoneNumber: digitsOnly
                )
                .environmentObject(otpManager)
                .environmentObject(authManager)
            }
        }
    }
}

struct PhoneNumScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        
        PhoneNumScreen(
            fullName: "",
            username: "",
            password: ""
        )
    }
}

