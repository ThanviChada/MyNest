//
//  PhoneNumScreen.swift
import SwiftUI

struct PhoneNumScreen: View {
    
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
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    Text("We’ll send a verification code on this number")
                        .font(.custom("Instrument Sans", size: 17).weight(.bold))
                        .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.49))
                    
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
                    .font(.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(formValid ? Color.green : Color.gray)
                    .cornerRadius(18)
                    .disabled(!formValid)
                    
                    NavigationLink("", destination: VerificationScreen()
                        .environmentObject(otpManager),
                                   isActive: $goToVerification)
                }
                .padding(28)
            }
        }
    }
}

//'init(_:destination:isActive:)' was deprecated in iOS 16.0: use NavigationLink(value:label:), or navigationDestination(isPresented:destination:), inside a NavigationStack or NavigationSplitView
