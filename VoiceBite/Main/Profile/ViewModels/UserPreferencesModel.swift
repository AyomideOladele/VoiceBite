//
//  UserPreferencesModel.swift
//  VoiceBite
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserPreferencesModel: ObservableObject {
    @Published var userPreferences: User

    private var db = Firestore.firestore()
    private var userId: String

    init(userId: String) {
        self.userId = userId
        self.userPreferences = User(id: userId, fullname: "", email: "", isDarkMode: false, chosenLanguage: "en-US", soundVolume: 50.0)
        Task {
            await fetchPreferences(userId: userId)
        }
    }

    func fetchPreferences(userId: String) async {
        let docRef = db.collection("users").document(userId)
        do {
            let documentSnapshot = try await docRef.getDocument()
            if let user = try? documentSnapshot.data(as: User.self) {
                DispatchQueue.main.async {
                    self.userPreferences = user
                    print("DEBUG: Successfully fetched user preferences")
                }
            } else {
                DispatchQueue.main.async {
                    print("DEBUG: Error fetching user preferences: Failed to decode User")
                }
            }
        } catch {
            DispatchQueue.main.async {
                print("DEBUG: Error fetching user preferences: \(error)")
            }
        }
    }

    func updatePreferences() async throws {
        let userRef = db.collection("users").document(self.userId)
        do {
            try await userRef.setData(try Firestore.Encoder().encode(self.userPreferences))
            print("DEBUG: Successfully updated user preferences")
        } catch {
            print("DEBUG: Error updating user preferences: \(error)")
            throw error
        }
    }
}
