//
//  SignInScreen.swift
//  MyNest
import SwiftUI

struct SignInScreen: View {
    
    // User input
    @State private var username = ""
    @State private var password = ""
    
    // Extra features
    @State private var showPassword = false
    @State private var rememberMe = false
    
    var body: some View {
        ZStack {
            
            // BACK TEXT
            Text("back")
                .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                .foregroundColor(Color(red: 0.54, green: 0.49, blue: 0.49))
                .offset(x: -145, y: -357.5)
            
            // USERNAME LABEL
            Text("Username")
                .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                .offset(x: -128.5, y: -241.5)
            
            // USERNAME FIELD
            TextField("Enter username", text: $username)
                .padding()
                .frame(width: 373, height: 65)
                .background(Color(red: 1, green: 0.98, blue: 0.98).opacity(0.44))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.76, green: 0.73, blue: 0.73), lineWidth: 1)
                )
                .offset(x: -3.5, y: -190.5)
            
            // PASSWORD LABEL
            Text("Password")
                .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                .offset(x: -132, y: -125.5)
            
            // PASSWORD FIELD + SHOW BUTTON
            ZStack(alignment: .trailing) {
                
                if showPassword {
                    TextField("Enter password", text: $password)
                        .padding()
                } else {
                    SecureField("Enter password", text: $password)
                        .padding()
                }
                
                Button(showPassword ? "Hide" : "Show") {
                    showPassword.toggle()
                }
                .foregroundColor(.blue)
                .padding(.trailing, 15)
            }
            .frame(width: 373, height: 68)
            .background(Color(red: 1, green: 0.98, blue: 0.98).opacity(0.44))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 0.76, green: 0.73, blue: 0.73), lineWidth: 1)
            )
            .offset(x: -3.5, y: -73)
            
            // REMEMBER ME + FORGOT PASSWORD ROW
            HStack {
                
                // CHECKBOX
                Button(action: {
                    rememberMe.toggle()
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                            .overlay(
                                Rectangle().stroke(Color.gray, lineWidth: 1)
                            )
                        
                        if rememberMe {
                            Text("✓")
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                }
                .buttonStyle(.plain) // removes extra box
                
                Text("Remember Me")
                    .font(Font.custom("Instrument Sans", size: 15).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                
                Spacer()
                
                Text("Forgot Password?")
                    .font(Font.custom("Instrument Sans", size: 15).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
            }
            .frame(width: 360)
            .offset(y: -18)
            
            // LOGIN BUTTON
            Button(action: {
                print("Username:", username)
                print("Password:", password)
                print("Remember Me:", rememberMe)
            }) {
                Text("Login")
                    .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
                    .background(Color(red: 0.459, green:0.694, blue: 0.184).opacity(100))
                    .cornerRadius(15)
            }
            .offset(y: 102.5)
            
        }
        .frame(width: 402, height: 874)
        .background(Color(red: 0.97, green: 0.94, blue: 0.88))
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
