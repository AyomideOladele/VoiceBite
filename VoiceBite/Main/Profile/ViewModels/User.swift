//
//  User.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 04/04/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    //let password: String
    
    // Retrieves users initals from their full name, returns empty string if invalid
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Ayo Oladele", email: "email@emails.com")
    
    //    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Ayo Oladele", givenName: "Ayo", email: "email@emails.com", password: ".............")
}
