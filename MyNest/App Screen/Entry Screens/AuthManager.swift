import Foundation
import SwiftUI

@MainActor
final class AuthManager: ObservableObject {
    @Published var currentUser: User?
    @Published var lastErrorMessage: String?
    @Published var didJustCreateAccount = false

    private let usersKey = "stored_users"
    private let loggedInKey = "logged_in_user"

    init() {
        // Always start the app at the entry screen instead of restoring the last session.
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: loggedInKey)
    }

    func createAccount(
        fullName: String,
        username: String,
        password: String,
        phoneNumber: String
    ) -> Bool {
        lastErrorMessage = nil
        didJustCreateAccount = true

        let trimmedFullName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedFullName.isEmpty,
              !trimmedUsername.isEmpty,
              !password.isEmpty,
              !trimmedPhone.isEmpty else {
            lastErrorMessage = "Please fill out every field."
            didJustCreateAccount = false
            return false
        }

        let newUser = User(
            id: UUID().uuidString,
            fullName: trimmedFullName,
            username: trimmedUsername,
            password: password,
            email: "",
            phoneNumber: trimmedPhone,
            phoneVerified: true
        )

        appendUser(newUser)
        currentUser = newUser
        saveLoggedInUser()
        return true
    }

    func login(username: String, password: String) -> Bool {
        lastErrorMessage = nil
        didJustCreateAccount = false

        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedUsername.isEmpty, !trimmedPassword.isEmpty else {
            lastErrorMessage = "Please enter a username and password."
            return false
        }

        let users = loadAllUsers()
        if let storedUser = users.first(where: {
            $0.username.lowercased() == trimmedUsername.lowercased()
        }) {
            currentUser = storedUser
        } else {
            currentUser = User(
                id: UUID().uuidString,
                fullName: trimmedUsername,
                username: trimmedUsername,
                password: trimmedPassword,
                email: "",
                phoneNumber: "",
                phoneVerified: false
            )
        }

        saveLoggedInUser()
        return true
    }

    func logout() {
        currentUser = nil
        didJustCreateAccount = false
        UserDefaults.standard.removeObject(forKey: loggedInKey)
    }

    private func appendUser(_ user: User) {
        var users = loadAllUsers()
        users.append(user)

        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: usersKey)
        }
    }

    private func loadAllUsers() -> [User] {
        guard
            let data = UserDefaults.standard.data(forKey: usersKey),
            let decoded = try? JSONDecoder().decode([User].self, from: data)
        else {
            return []
        }

        return decoded
    }

    private func saveLoggedInUser() {
        if let encoded = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: loggedInKey)
        }
    }

}
