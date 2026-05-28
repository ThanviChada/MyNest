import SwiftUI

struct SignInScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var rememberMe = false
    @State private var showError = false
    
    // validation
    var canLogin: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.87, green: 0.9, blue: 0.9)
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    
                    // Back button
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.gray)
                            
                            Text("Back")
                                .font(Font.custom("Instrument Sans", size: 16).weight(.bold))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    Spacer().frame(height: 5)
                    
                    // USERNAME
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                            .foregroundColor(.black)
                        
                        ZStack(alignment: .leading) {
                            if username.isEmpty {
                                Text("Enter username")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .font(.system(size: 16))
                            }
                            
                            TextField("", text: $username)
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
                    .padding(.horizontal, 25)
                    
                    // PASSWORD
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                            .foregroundColor(.black)
                        
                        ZStack(alignment: .trailing) {
                            ZStack(alignment: .leading) {
                                if password.isEmpty {
                                    Text("Enter password")
                                        .foregroundColor(.gray.opacity(0.6))
                                        .font(.system(size: 16))
                                }
                                
                                if showPassword {
                                    TextField("", text: $password)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                } else {
                                    SecureField("", text: $password)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                }
                            }
                            
                            Button(showPassword ? "Hide" : "Show") {
                                showPassword.toggle()
                            }
                            .padding(.trailing, 5)
                            .foregroundColor(.gray)
                        }
                        .padding(.bottom, 8)
                        .overlay(
                            Rectangle()
                                .frame(height: 1.2)
                                .foregroundColor(Color.gray.opacity(0.4)),
                            alignment: .bottom
                        )
                    }
                    .padding(.horizontal, 25)
                    
                    // Remember Me + Forgot
                    HStack {
                        Button {
                            rememberMe.toggle()
                        } label: {
                            HStack {
                                Rectangle()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.white)
                                    .overlay(Rectangle().stroke(Color.gray))
                                    .overlay(
                                        Text(rememberMe ? "✓" : "")
                                    )
                                
                                Text("Remember Me")
                                    .font(Font.custom("Instrument Sans", size: 15).weight(.bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Text("Forgot Password?")
                            .font(Font.custom("Instrument Sans", size: 15).weight(.bold))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 25)
                    
                    // LOGIN BUTTON
                    Button(action: {
                        let success = authManager.login(username: username, password: password)
                        showError = !success
                    }) {
                        Text("Login")
                            .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                canLogin
                                ? Color(red: 0.459, green: 0.694, blue: 0.184)
                                : Color.gray.opacity(0.5)
                            )
                            .cornerRadius(15)
                    }
                    .disabled(!canLogin)
                    .padding(.horizontal, 60)
                    
                    if showError {
                        Text("Invalid username or password.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SignInScreen()
        .environmentObject(AuthManager())
}
