import Foundation

class OTPManager: ObservableObject {
    
    @Published var generatedCode: String = ""
    @Published var phoneNumber: String = ""
    
    // generate 4 digit code
    func sendOTP(to number: String) {
        phoneNumber = number
        generatedCode = String(Int.random(in: 1000...9999))
        
        // simulate sending SMS
        print("📲 OTP sent to \(number):", generatedCode)
    }
    
    func verify(code: String) -> Bool {
        return code == generatedCode
    }
    
    func resend() {
        sendOTP(to: phoneNumber)
    }
}

