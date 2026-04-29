import SwiftUI

struct CreateAccount: View {
    
    @State private var fullName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showError = false
    @State private var goToHome = false   // ✅ already added (kept)

    var formValid: Bool {
        !fullName.isEmpty &&
        !username.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword
    }
    
    var body: some View {
        NavigationStack {   // ✅ keep NavigationStack
            ZStack {
                
                // Background
                Color(red: 0.92, green: 0.94, blue: 0.89)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    
                    // Top Bar
                    HStack {
                        Button(action: {
                            print("Back tapped")
                        }) {
                            Text("Back")
                                .font(.custom("Instrument Sans", size: 18).weight(.bold))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    
                    // Logo
                    Image("myNest_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    
                    // Title
                    Text("Create Account")
                        .font(.custom("Instrument Sans", size: 26).weight(.bold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    // Input Fields
                    VStack(spacing: 18) {
                        
                        customField(title: "Name*", text: $fullName, placeholder: "Full Name")
                        
                        customField(title: "Username*", text: $username, placeholder: "Username")
                        
                        passwordField(
                            title: "Password*",
                            text: $password,
                            isVisible: $showPassword,
                            placeholder: "Password"
                        )
                        
                        passwordField(
                            title: "Re-enter Password*",
                            text: $confirmPassword,
                            isVisible: $showConfirmPassword,
                            placeholder: "Confirm Password"
                        )
                    }
                    .padding(.horizontal, 25)
                    
                    // Error message
                    if showError {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    // Create Button
                    Button(action: {
                        if password != confirmPassword {
                            showError = true
                            return
                        }
                        
                        showError = false
                        print("Account Created")
                        
                        goToHome = true   // ✅ NAVIGATE TRIGGER
                        
                    }) {
                        Text("Create")
                            .font(.custom("Instrument Sans", size: 20).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(formValid ? Color(red: 0.13, green: 0.49, blue: 0.69) : Color.gray)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    .disabled(!formValid)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 20)
                }
            }
            // ✅ NAVIGATION (THIS WAS THE ISSUE)
            .navigationDestination(isPresented: $goToHome) {
                HomeScreen()
            }
        }
    }
    
    //////////////////////////////////////////////////
    // MARK: - Custom Components
    //////////////////////////////////////////////////
    
    func customField(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.custom("Instrument Sans", size: 16).weight(.bold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            TextField(placeholder, text: text)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        }
    }
    
    func passwordField(
        title: String,
        text: Binding<String>,
        isVisible: Binding<Bool>,
        placeholder: String
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.custom("Instrument Sans", size: 16).weight(.bold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            HStack {
                if isVisible.wrappedValue {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
                
                Button(action: {
                    isVisible.wrappedValue.toggle()
                }) {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}

