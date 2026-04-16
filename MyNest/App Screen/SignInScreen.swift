//
//  SignInScreen.swift
//  MyNest
import SwiftUI

struct SignInScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var rememberMe = false
    
    var body: some View {
        
        ZStack {
            Color(red: 0.97, green: 0.94, blue: 0.87)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                // BACK BUTTON NOW WORKS
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("< Back")
                            .font(Font.custom("Instrument Sans", size: 20).weight(.bold))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, 10)
                
                Spacer()
                
                // Username
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    
                    TextField("Enter username", text: $username)
                        .padding()
                        .frame(height: 60)
                        .background(Color(red: 1, green: 0.98, blue: 0.98).opacity(0.44))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                }
                .padding(.horizontal, 25)
                
                // Password
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                    
                    ZStack(alignment: .trailing) {
                        if showPassword {
                            TextField("Enter password", text: $password).padding()
                        } else {
                            SecureField("Enter password", text: $password).padding()
                        }
                        
                        Button(showPassword ? "Hide" : "Show") {
                            showPassword.toggle()
                        }
                        .padding(.trailing, 15)
                    }
                    .frame(height: 60)
                    .background(Color(red: 1, green: 0.98, blue: 0.98).opacity(0.44))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                }
                .padding(.horizontal, 25)
                
                // Remember me row
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
                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Text("Forgot Password?")
                        .font(Font.custom("Instrument Sans", size: 15).weight(.bold))
                        .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                }
                .padding(.horizontal, 25)
                
                // Login Button
                Button("Login") {
                    print(username, password, rememberMe)
                }
                .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(red: 0.459, green: 0.694, blue: 0.184))
                .cornerRadius(15)
                .padding(.horizontal, 60)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignInScreen()
}
