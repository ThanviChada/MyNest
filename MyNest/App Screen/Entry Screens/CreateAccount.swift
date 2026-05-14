import SwiftUI

struct CreateAccount: View {
    
    @State private var fullName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showError = false
    @State private var goToHome = false
    
    
    var passwordValid: Bool {
        let uppercase = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let lowercase = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let number = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        let symbol = NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z0-9]+.*")

        return password.count >= 8 &&
        uppercase.evaluate(with: password) &&
        lowercase.evaluate(with: password) &&
        number.evaluate(with: password) &&
        symbol.evaluate(with: password)
    }
    

    // MARK: - Form Validation
    var formValid: Bool {
        !fullName.isEmpty &&
        !username.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword &&
        passwordValid
    }

    var body: some View {
        NavigationStack {
            ZStack {
                
                // Background
                LinearGradient(
                    colors: [
                        Color(red: 0.94, green: 0.96, blue: 0.92),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 22) {

                    // Back button
                    HStack {
                        Button(action: {
                            print("Back tapped")
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 28)

                    Spacer(minLength: 10)

                    // Logo
                    Image("myNest_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)

                    // Title
                    VStack(spacing: 6) {
                        
                        Text("Create Account")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color(red: 0.35, green: 0.20, blue: 0.12))
                    }
                    
                    // Input Fields
                    VStack(spacing: 24) {

                        lineField(title: "Name", text: $fullName, placeholder: "Full Name")

                        lineField(title: "Username", text: $username, placeholder: "Username")

                        passwordField(title: "Password", text: $password, isVisible: $showPassword, placeholder: "Password")

                        passwordField(title: "Confirm Password", text: $confirmPassword, isVisible: $showConfirmPassword, placeholder: "Re-enter Password")

                        // Requirements
                        VStack(alignment: .leading, spacing: 5) {
                            requirementRow(text: "8+ chars", valid: password.count >= 8)
                            requirementRow(text: "Uppercase", valid: password.range(of: "[A-Z]", options: .regularExpression) != nil)
                            requirementRow(text: "Lowercase", valid: password.range(of: "[a-z]", options: .regularExpression) != nil)
                            requirementRow(text: "Number", valid: password.range(of: "[0-9]", options: .regularExpression) != nil)
                            requirementRow(text: "Symbol", valid: password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil)
                        }
                        .font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, 30)

                    // Error message
                    if showError {
                        Text("Passwords do not match")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    Spacer()

                    // Create account button
                    Button(action: {
                        if password != confirmPassword || !passwordValid {
                            showError = true
                            return
                        }

                        showError = false

                        // ✅ ONLY ADDITION
                        isNewUser = true

                        goToHome = true
                    }) {
                        Text("Create Account")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                formValid
                                ? Color(red: 0.13, green: 0.49, blue: 0.69)
                                : Color.gray.opacity(0.5)
                            )
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    }
                    .disabled(!formValid)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
            }
            .navigationDestination(isPresented: $goToHome) {
                HomeScreen()
            }
        }
    }
    
    
    func lineField(
        title: String,
        text: Binding<String>,
        placeholder: String
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            ZStack(alignment: .leading) {
                
                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.75))
                        .font(.system(size: 16))
                }
                
                TextField("", text: text)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            .padding(.bottom, 8)
            .overlay(
                Rectangle()
                    .frame(height: 1.2)
                    .foregroundColor(Color.gray.opacity(0.4)),
                alignment: .bottom
            )
        }
    }

    
    func passwordField(
        title: String,
        text: Binding<String>,
        isVisible: Binding<Bool>,
        placeholder: String
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            
            HStack {
                
                ZStack(alignment: .leading) {
                    
                    if text.wrappedValue.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray.opacity(0.75))
                            .font(.system(size: 16))
                    }
                    
                    if isVisible.wrappedValue {
                        
                        TextField("", text: text)
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                        
                    } else {
                        
                        SecureField("", text: text)
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                }
                
                Button(action: {
                    isVisible.wrappedValue.toggle()
                }) {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }

            // ✅ NAVIGATION (with new user flag)
            .navigationDestination(isPresented: $goToHome) {
                HomeScreen(isNewUser: isNewUser)
            }
        }
    }
}


func lineField(
    title: String,
    text: Binding<String>,
    placeholder: String
) -> some View {
    VStack(alignment: .leading, spacing: 8) {
        Text(title)
            .font(.custom("Instrument Sans", size: 15).weight(.semibold))
            .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))

        TextField(placeholder, text: text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .padding(.bottom, 8)
            .overlay(
                Rectangle()
                    .frame(height: 1.2)
                    .foregroundColor(Color.gray.opacity(0.4)),
                alignment: .bottom
            )
        }
    }
    
    func requirementRow(text: String, valid: Bool) -> some View {
        
        HStack(spacing: 6) {
            
            Image(systemName: valid ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 10))
                .foregroundColor(valid ? .green : .gray.opacity(0.5))
            
            Text(text)
                .foregroundColor(valid ? .green : .gray)
        }
    }
}

        Text(text)
            .foregroundColor(valid ? .green : .gray)
    }
}
struct CreateAccount_Previews: PreviewProvider {
static var previews: some View {
    CreateAccount()
}
}
