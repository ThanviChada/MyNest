import SwiftUI

struct VerificationScreen: View {
    
    let fullName: String
    let username: String
    let password: String
    let phoneNumber: String
    
    @EnvironmentObject var otpManager: OTPManager
    @EnvironmentObject var authManager: AuthManager
    
    @State private var code1 = ""
    @State private var code2 = ""
    @State private var code3 = ""
    @State private var code4 = ""
    @State private var isSubmitting = false
    
    var enteredCode: String {
        code1 + code2 + code3 + code4
    }
    
    var codeComplete: Bool {
        enteredCode.count == 4
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(red: 0.17, green: 0.65, blue: 0.84)
                    .opacity(0.08)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    Text("Verification")
                        .font(.custom("Instrument Sans", size: 48).weight(.bold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    Text("We sent a code to \(otpManager.phoneNumber)")
                        .foregroundColor(.gray)
                    
                    Spacer().frame(height: 40)
                    
                    HStack(spacing: 18) {
                        otpBox(text: $code1)
                        otpBox(text: $code2)
                        otpBox(text: $code3)
                        otpBox(text: $code4)
                    }

                    if let errorMessage = otpManager.lastErrorMessage ?? authManager.lastErrorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    Button {
                        guard let verificationID = otpManager.verificationID else {
                            authManager.lastErrorMessage = "Missing verification session. Please resend the code."
                            return
                        }
                        
                        isSubmitting = true
                        
                        Task {
                            let success = await authManager.createAccount(
                                fullName: fullName,
                                username: username,
                                password: password,
                                phoneNumber: phoneNumber,
                                verificationID: verificationID,
                                verificationCode: enteredCode
                            )
                            
                            isSubmitting = false
                            
                            if success {
                                otpManager.clearVerificationState()
                            }
                        }
                    } label: {
                        HStack {
                            if isSubmitting {
                                ProgressView()
                                    .tint(.white)
                            }
                            
                            Text(isSubmitting ? "Saving..." : "Continue")
                        }
                    }
                    .font(.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(codeComplete && !isSubmitting ? Color.green : Color.gray)
                    .cornerRadius(18)
                    .disabled(!codeComplete || isSubmitting)
                    
                    VStack {
                        Text("Didn’t receive a code?")
                        
                        Button("RESEND") {
                            Task {
                                _ = await otpManager.resend()
                            }
                        }
                        .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(28)
            }
        }
    }
}

func otpBox(text: Binding<String>) -> some View {
    
    TextField("", text: text)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .font(.title)
        .frame(width: 64, height: 68)
        .background(Color.white)
        .cornerRadius(10)
        .onChange(of: text.wrappedValue) { newValue in
            
            if newValue.count > 1 {
                text.wrappedValue = String(newValue.prefix(1))
            }
            
            text.wrappedValue = text.wrappedValue.filter { $0.isNumber }
        }
}
