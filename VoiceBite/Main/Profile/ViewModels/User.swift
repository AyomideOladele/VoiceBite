//
//  User.swift
//  VoiceBite
//
// A simple data model for a user, defines properties: id, fullname and email.

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var isDarkMode: Bool
    var chosenLanguage: String
    var soundVolume: Double
}

// Mock user, for testing
extension User {
    static var MOCK_USER = User(
        id: NSUUID().uuidString,
        fullname: "User's Name",
        email: "email@emails.com",
        isDarkMode: false,
        chosenLanguage: "en-US",
        soundVolume: 50.0
    )
}
