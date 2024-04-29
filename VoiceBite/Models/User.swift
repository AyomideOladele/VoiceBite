//
//  User.swift
//  VoiceBite
//
// A model for a user

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var isDarkMode: Bool
    var chosenLanguage: String
}
