//
//  User.swift
//  MyNest
//
//  Created by Trayi Kopparapu on 5/26/26.
//
import Foundation

struct User: Codable, Identifiable {
    
    var id = UUID()
    
    var fullName: String
    var username: String
    var password: String
    var phoneNumber: String
    var phoneVerified: Bool
}
