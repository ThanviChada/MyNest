//
//  AuthManager.swift
//  MyNest
//
//  Created by Trayi Kopparapu on 5/26/26.
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject {
    
    @Published var users: [User] = []
    @Published var currentUser: User?
    
    private let usersKey = "stored_users"
    private let loggedInKey = "logged_in_user"
    
    init() {
        loadUsers()
        loadLoggedInUser()
    }
    
    func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: usersKey)
        }
    }
    
    func loadUsers() {
        guard let data = UserDefaults.standard.data(forKey: usersKey),
              let decoded = try? JSONDecoder().decode([User].self, from: data)
        else { return }
        
        users = decoded
    }
    
    func createAccount(
        fullName: String,
        username: String,
        password: String,
        phoneNumber: String
    ) {
        
        let newUser = User(
            fullName: fullName,
            username: username,
            password: password,
            phoneNumber: phoneNumber,
            phoneVerified: true
        )
        
        users.append(newUser)
        currentUser = newUser
        
        saveUsers()
        saveLoggedInUser()
    }
    
    func login(username: String, password: String) -> Bool {
        
        if let foundUser = users.first(where: {
            $0.username == username &&
            $0.password == password
        }) {
            
            currentUser = foundUser
            saveLoggedInUser()
            return true
        }
        
        return false
    }
    
    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: loggedInKey)
    }
    
    func saveLoggedInUser() {
        if let encoded = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: loggedInKey)
        }
    }
    
    func loadLoggedInUser() {
        guard let data = UserDefaults.standard.data(forKey: loggedInKey),
              let decoded = try? JSONDecoder().decode(User.self, from: data)
        else { return }
        
        currentUser = decoded
    }
}
