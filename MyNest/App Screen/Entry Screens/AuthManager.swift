import Foundation
import SwiftUI
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

@MainActor
final class AuthManager: ObservableObject {
    @Published var currentUser: User?
    @Published var lastErrorMessage: String?

    private let profileKey = "logged_in_user_profile"
    private let databaseURL = URL(string: "https://mynest-4c678-default-rtdb.firebaseio.com")!
    private let userPath = "users"

    init() {
        loadCachedUser()

        Task {
            await refreshCurrentUser()
        }
    }

    func createAccount(
        fullName: String,
        username: String,
        password: String,
        phoneNumber: String,
        verificationID: String,
        verificationCode: String
    ) async -> Bool {
        lastErrorMessage = nil

#if canImport(FirebaseAuth)

        let email = emailAddress(for: username)
        let phoneCredential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )

        do {
            if Auth.auth().currentUser != nil {
                try Auth.auth().signOut()
            }

            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let linkedResult = try await authResult.user.link(with: phoneCredential)

            let profile = User(
                id: linkedResult.user.uid,
                fullName: fullName,
                username: username,
                email: email,
                phoneNumber: phoneNumber,
                phoneVerified: true
            )

            try await saveProfile(profile)
            currentUser = profile
            saveCachedUser(profile)
            return true
        } catch {
            lastErrorMessage = error.localizedDescription
            return false
        }
#else
        lastErrorMessage = "FirebaseAuth is not linked to the MyNest target yet."
        return false
#endif
    }

    func login(username: String, password: String) async -> Bool {
        lastErrorMessage = nil

#if canImport(FirebaseAuth)

        do {
            let email = emailAddress(for: username)
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)

            if let profile = try await fetchProfile(uid: authResult.user.uid) {
                currentUser = profile
                saveCachedUser(profile)
            } else {
                let fallbackUser = User(
                    id: authResult.user.uid,
                    fullName: authResult.user.displayName ?? "",
                    username: username,
                    email: email,
                    phoneNumber: authResult.user.phoneNumber ?? "",
                    phoneVerified: authResult.user.phoneNumber != nil
                )
                currentUser = fallbackUser
                saveCachedUser(fallbackUser)
            }

            return true
        } catch {
            lastErrorMessage = error.localizedDescription
            return false
        }
#else
        lastErrorMessage = "FirebaseAuth is not linked to the MyNest target yet."
        return false
#endif
    }

    func logout() {
#if canImport(FirebaseAuth)
        do {
            try Auth.auth().signOut()
        } catch {
            lastErrorMessage = error.localizedDescription
        }
#endif

        currentUser = nil
        UserDefaults.standard.removeObject(forKey: profileKey)
    }

    func refreshCurrentUser() async {
#if canImport(FirebaseAuth)
        guard let firebaseUser = Auth.auth().currentUser else {
            currentUser = nil
            return
        }

        do {
            if let profile = try await fetchProfile(uid: firebaseUser.uid) {
                currentUser = profile
                saveCachedUser(profile)
            } else {
                let derivedUsername = firebaseUser.email?
                    .replacingOccurrences(of: "@mynest.local", with: "") ?? ""

                let fallbackUser = User(
                    id: firebaseUser.uid,
                    fullName: firebaseUser.displayName ?? "",
                    username: derivedUsername,
                    email: firebaseUser.email ?? emailAddress(for: derivedUsername),
                    phoneNumber: firebaseUser.phoneNumber ?? "",
                    phoneVerified: firebaseUser.phoneNumber != nil
                )

                currentUser = fallbackUser
                saveCachedUser(fallbackUser)
                try await saveProfile(fallbackUser)
            }
        } catch {
            lastErrorMessage = error.localizedDescription
        }
#else
        currentUser = nil
#endif
    }

    private func emailAddress(for username: String) -> String {
        let trimmed = username
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        let cleaned = trimmed.replacingOccurrences(
            of: #"[^a-z0-9._%+-]"#,
            with: ".",
            options: .regularExpression
        )

        let localPart = cleaned.isEmpty ? UUID().uuidString.replacingOccurrences(of: "-", with: "") : cleaned
        return "\(localPart)@mynest.local"
    }

    private func fetchProfile(uid: String) async throws -> User? {
        let url = databaseURL
            .appendingPathComponent(userPath)
            .appendingPathComponent("\(uid).json")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return nil
        }

        if data.isEmpty {
            return nil
        }

        if let rawValue = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines),
           rawValue == "null" {
            return nil
        }

        return try JSONDecoder().decode(User.self, from: data)
    }

    private func saveProfile(_ profile: User) async throws {
        let url = databaseURL
            .appendingPathComponent(userPath)
            .appendingPathComponent("\(profile.id).json")

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(profile)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }

    private func saveCachedUser(_ profile: User) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: profileKey)
        }
    }

    private func loadCachedUser() {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let decoded = try? JSONDecoder().decode(User.self, from: data)
        else {
            return
        }

        currentUser = decoded
    }
}
