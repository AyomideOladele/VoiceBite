//
//  User.swift
//  VoiceBite
//
// A model for a user, defines properties: id, fullname and email.

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var isDarkMode: Bool
    var chosenLanguage: String
}

// Mock user, for testing
extension User {
    static var MOCK_USER = User(
        id: NSUUID().uuidString,
        fullname: "User Name",
        email: "email@emails.com",
        isDarkMode: false,
        chosenLanguage: "en-GB"
    )
}
