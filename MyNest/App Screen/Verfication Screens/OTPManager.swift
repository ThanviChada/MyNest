import Foundation
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

@MainActor
final class OTPManager: ObservableObject {
    @Published var phoneNumber = ""
    @Published var verificationID: String?
    @Published var lastErrorMessage: String?

    private let verificationKey = "authVerificationID"

    init() {
        verificationID = UserDefaults.standard.string(forKey: verificationKey)
    }

    func sendOTP(to number: String) async -> Bool {
        phoneNumber = number
        lastErrorMessage = nil

#if canImport(FirebaseAuth)
        return await withCheckedContinuation { continuation in
            PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
                if let verificationID {
                    self.verificationID = verificationID
                    UserDefaults.standard.set(verificationID, forKey: self.verificationKey)
                    continuation.resume(returning: true)
                    return
                }

                self.lastErrorMessage = error?.localizedDescription ?? "Unable to send verification code."
                continuation.resume(returning: false)
            }
        }
#else
        lastErrorMessage = "FirebaseAuth is not linked to the MyNest target yet."
        return false
#endif
    }

    func resend() async -> Bool {
        guard !phoneNumber.isEmpty else {
            lastErrorMessage = "Missing phone number."
            return false
        }

        return await sendOTP(to: phoneNumber)
    }

    func clearVerificationState() {
        verificationID = nil
        UserDefaults.standard.removeObject(forKey: verificationKey)
    }
}
