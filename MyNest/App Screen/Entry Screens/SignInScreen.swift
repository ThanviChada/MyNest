import SwiftUI

struct SignInScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager

    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var rememberMe = false
    @State private var showError = false
    @State private var isSigningIn = false

    var canLogin: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.94, green: 0.96, blue: 0.94),
                        Color(red: 0.88, green: 0.92, blue: 0.91),
                        Color(red: 0.82, green: 0.88, blue: 0.87)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                Circle()
                    .fill(Color.white.opacity(0.35))
                    .frame(width: 220, height: 220)
                    .blur(radius: 28)
                    .offset(x: 140, y: -260)

                Circle()
                    .fill(Color(red: 0.82, green: 0.90, blue: 0.86).opacity(0.55))
                    .frame(width: 260, height: 260)
                    .blur(radius: 26)
                    .offset(x: -150, y: 260)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 22) {
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18, weight: .semibold))
                                    Text("Back")
                                        .font(Font.custom("Instrument Sans", size: 16).weight(.bold))
                                }
                                .foregroundColor(.gray.opacity(0.85))
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 22)
                        .padding(.top, 18)

                        VStack(spacing: 10) {
                            Image("myNest_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 8)

                            Text("Welcome back")
                                .font(.custom("Instrument Sans", size: 15).weight(.semibold))
                                .tracking(1.4)
                                .foregroundColor(Color(red: 0.23, green: 0.35, blue: 0.31).opacity(0.7))

                            Text("Sign In")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(Color(red: 0.24, green: 0.15, blue: 0.10))

                            Text("Use any username and password to continue.")
                                .font(.custom("Instrument Sans", size: 16).weight(.medium))
                                .foregroundColor(Color(red: 0.34, green: 0.39, blue: 0.37))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 26)
                        .padding(.top, 10)

                        VStack(spacing: 18) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(Font.custom("Instrument Sans", size: 16).weight(.semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))

                                ZStack(alignment: .leading) {
                                    if username.isEmpty {
                                        Text("Enter username")
                                            .foregroundColor(.gray.opacity(0.55))
                                            .font(.system(size: 16))
                                    }

                                    TextField("", text: $username)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                }
                                .padding(.bottom, 10)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1.2)
                                        .foregroundColor(Color.gray.opacity(0.35)),
                                    alignment: .bottom
                                )
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(Font.custom("Instrument Sans", size: 16).weight(.semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))

                                HStack {
                                    ZStack(alignment: .leading) {
                                        if password.isEmpty {
                                            Text("Enter password")
                                                .foregroundColor(.gray.opacity(0.55))
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
                                .padding(.bottom, 10)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1.2)
                                        .foregroundColor(Color.gray.opacity(0.35)),
                                    alignment: .bottom
                                )
                            }
                        }
                        .padding(22)
                        .background(.white.opacity(0.72))
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 10)
                        .padding(.horizontal, 18)

                        HStack {
                            Button {
                                rememberMe.toggle()
                            } label: {
                                HStack(spacing: 10) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(rememberMe ? Color(red: 0.13, green: 0.49, blue: 0.69) : .white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                                        )
                                        .overlay(
                                            Text(rememberMe ? "✓" : "")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.white)
                                        )
                                        .frame(width: 22, height: 22)

                                    Text("Remember Me")
                                        .font(Font.custom("Instrument Sans", size: 15).weight(.semibold))
                                        .foregroundColor(Color(red: 0.16, green: 0.22, blue: 0.22))
                                }
                            }
                            .buttonStyle(.plain)

                            Spacer()

                            Text("Forgot Password?")
                                .font(Font.custom("Instrument Sans", size: 15).weight(.semibold))
                                .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                        }
                        .padding(.horizontal, 26)

                        Button {
                            isSigningIn = true

                            Task {
                                let success = authManager.login(username: username, password: password)
                                showError = !success
                                isSigningIn = false
                            }
                        } label: {
                            HStack(spacing: 10) {
                                if isSigningIn {
                                    ProgressView()
                                        .tint(.white)
                                }

                                Text(isSigningIn ? "Signing In..." : "Login")
                            }
                            .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(
                                canLogin && !isSigningIn
                                ? LinearGradient(
                                    colors: [
                                        Color(red: 0.13, green: 0.49, blue: 0.69),
                                        Color(red: 0.10, green: 0.38, blue: 0.55)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                : LinearGradient(
                                    colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.45)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.14), radius: 10, x: 0, y: 5)
                        }
                        .disabled(!canLogin || isSigningIn)
                        .padding(.horizontal, 26)

                        if showError || authManager.lastErrorMessage != nil {
                            Text(authManager.lastErrorMessage ?? "Invalid username or password.")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.top, 2)
                        }

                        Spacer(minLength: 20)
                    }
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
