//
//  AuthViewModel.swift
//  VoiceBite
//
// A viewmodel for managing the authentication state of the user, and user preferences

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit

// Defines protocol for validating authentication forms
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // Stores whether a user is logged in
    @Published var currentUser: User? // Stores current users details
    @Published var errorMessage: String? // Sets error message to be sent to listening views
    
    // Fetches current user data on initialisation of view model if a user is currently logged in
    init(){
            self.userSession = Auth.auth().currentUser
            Task {
                await fetchUser()
            }
        }
    
    // Attempts to sign user in using user input and set current session
    func signIn(withEmail email: String, password: String) async throws {
        do {
            // Checks user's details against collection and returns matching user ID
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            // Sets current session to retrived user ID
            self.userSession = result.user
            
            // Fetches copy of user to be used to display details in account view
            await fetchUser()
            
            errorMessage = nil
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    // Registers a new user's details, uploads them to database,
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // Adds users email and password to database and returns a user ID
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // Sets the user session to the new user using their user ID
            self.userSession = result.user
            
            // Creates a user data model for the new user
            let user = User(id: result.user.uid, fullname: fullname, email: email,
                            isDarkMode: false, chosenLanguage: "en-US")
            
            // Converts user details (full name and preferences) into form firebase can handle
            let encodedUser = try Firestore.Encoder().encode(user)
            
            // Adds user details to users collection in database
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            // Fetches copy of user to be used to display details in account view
            await fetchUser()
            
            errorMessage = nil
            
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    // Signs out the current user and clears session information.
    func signOut() {
        do {
            // Signs user out in the backend
            try Auth.auth().signOut()
            
            self.userSession = nil  // Sets user session returning the app to the login screen
            self.currentUser = nil // Clears current user data model
            
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    // Delete's users details from database, and clears local session data
    func deleteAccount() async {
        
        let user = Auth.auth().currentUser!

        do {
            // Deletes users details from database collection
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            
            // Signs user out of current session
            try Auth.auth().signOut()

            // Delete's users authentication details from firebase
            try await user.delete()
 
            self.userSession = nil // Sets user session returning the app to the login screen
            self.currentUser = nil // Clears current user data model
        } catch {
            print("DEBUG: Error deleting user: \(error.localizedDescription)")
        }
    }
    
    // Fetches user information from database using the current user's UID.
    func fetchUser() async {
        // Retrieves the user ID of the current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Fetches collection matching user ID
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        
        // Attempts to decode document and store in User data model
        self.currentUser = try? snapshot.data(as: User.self)
        
        // Prints error statement depending on whether or not it was successful
        if let user = self.currentUser {
            print("DEBUG: Current user is \(user)")
        } else {
            print("DEBUG: Current user is nil")
        }
    }
    
    // Updates users preferences in database
    func updateUserPreferences(isDarkMode: Bool, chosenLanguage: String) async throws {
        
        // Checks that there is currently a user session
        guard let userSession = self.userSession else {
            print("DEBUG: No user session found")
            return
        }
        
        // Creates an updated user based on current users details, or uses an empty data model
        var updatedUser = self.currentUser ?? User(id: userSession.uid, fullname: "", email: "", isDarkMode: false, chosenLanguage: "en-US")
        
        // Sets updated users details to changed preferences
        updatedUser.isDarkMode = isDarkMode
        updatedUser.chosenLanguage = chosenLanguage
        
        // Creates a reference to the users document in database
        let userRef = Firestore.firestore().collection("users").document(userSession.uid)
        do {
            // Updates current users documents with updated user
            try await userRef.setData(try Firestore.Encoder().encode(updatedUser))
            
            // Fetches copy of user to be used to display details in account view
            await fetchUser()
            
            print("DEBUG: Successfully updated user preferences")
        } catch {
            print("DEBUG: Error updating user preferences: \(error.localizedDescription)")
            throw error
        }
    }
}
