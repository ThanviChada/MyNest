import SwiftUI

struct CreateAccount: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager

    @State private var fullName = ""
    @State private var username = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var showPassword = false
    @State private var showConfirmPassword = false

    var formValid: Bool {
        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.94, green: 0.96, blue: 0.92),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 22) {
                        HStack {
                            Button(action: {
                                dismiss()
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
                        .padding(.top, 18)

                        Spacer(minLength: 8)

                        Image("myNest_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180)
                            .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 10)

                        VStack(spacing: 6) {
                            Text("Create Account")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color(red: 0.35, green: 0.20, blue: 0.12))

                            Text("Enter anything to get started. The app will take you right to Home.")
                                .font(.custom("Instrument Sans", size: 16).weight(.medium))
                                .foregroundColor(Color(red: 0.34, green: 0.39, blue: 0.37))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 24)

                        VStack(spacing: 15) {
                            lineField(title: "Name", text: $fullName, placeholder: "Full Name")
                            lineField(title: "Username", text: $username, placeholder: "Username")
                            lineField(title: "Phone", text: $phoneNumber, placeholder: "Phone Number")

                            passwordField(title: "Password", text: $password, isVisible: $showPassword, placeholder: "Password")
                            passwordField(title: "Confirm Password", text: $confirmPassword, isVisible: $showConfirmPassword, placeholder: "Re-enter Password")
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 18)
                        .background(.white.opacity(0.72))
                        .overlay(
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                        .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 10)
                        .padding(.horizontal, 18)

                        if let errorMessage = authManager.lastErrorMessage {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        Button(action: {
                            let success = authManager.createAccount(
                                fullName: fullName,
                                username: username,
                                password: password,
                                phoneNumber: phoneNumber
                            )

                            if success {
                                dismiss()
                            }
                        }) {
                            Text("Create Account")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    formValid
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
                        .disabled(!formValid)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    func lineField(title: String, text: Binding<String>, placeholder: String) -> some View {
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
            .overlay(Rectangle().frame(height: 1.2).foregroundColor(Color.gray.opacity(0.4)), alignment: .bottom)
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
                    } else {
                        SecureField("", text: text)
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                    }
                }

                Button(action: { isVisible.wrappedValue.toggle() }) {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 8)
            .overlay(Rectangle().frame(height: 1.2).foregroundColor(Color.gray.opacity(0.4)), alignment: .bottom)
        }
    }
}

#Preview {
    CreateAccount()
        .environmentObject(AuthManager())
}
