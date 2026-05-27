import Foundation

class OTPManager: ObservableObject {
    
    @Published var phoneNumber = ""
    
    private var generatedCode = ""
    
    // SEND OTP
    
    func sendOTP(to number: String) {
        
        phoneNumber = number
        
        generatedCode = String(Int.random(in: 1000...9999))
        
        print("✅ OTP CODE: \(generatedCode)")
    }
    
    // VERIFY OTP
    
    func verify(code: String) -> Bool {
        return code == generatedCode
    }
    
    // RESEND
    
    func resend() {
        sendOTP(to: phoneNumber)
    }
}
