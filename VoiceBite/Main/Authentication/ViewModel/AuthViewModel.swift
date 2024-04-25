//
//  AuthViewModel.swift
//  VoiceBite
//
// Manages the authentication state of the user
//
// TODO: Add error message for user signout and delete on account view
// TODO: Create resetPassword()

import Foundation
import Firebase
import FirebaseFirestoreSwift

// Defines protocol for validating authentication forms
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? //Stores whether a user is logged in
    @Published var currentUser: User? // Stores current users details
    @Published var errorMessage: String?
    @Published var preferencesModel: UserPreferencesModel?
    
    // Initialises the view model by checking if a user is currently logged in
    init(){
        self.userSession = Auth.auth().currentUser
        if let user = userSession {
                    self.preferencesModel = UserPreferencesModel(userId: user.uid)
                }
        Task {
            await fetchUser() // Fetches user data if they are logged in
        }
    }
    
    func setupPreferencesModel(userId: String) {
            self.preferencesModel = UserPreferencesModel(userId: userId)
        }
    
    // Attempts to sign user in using user input and set current session
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.preferencesModel = UserPreferencesModel(userId: result.user.uid)
            await fetchUser()
            errorMessage = nil // No error occured, so error message is empty
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    // Registers a new user's details, uploads them to Firestore, and creates app session.
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email,
                            isDarkMode: false, chosenLanguage: "en-US")
            self.preferencesModel = UserPreferencesModel(userId: result.user.uid)
            let encodedUser = try Firestore.Encoder().encode(user) // Converts user details into form firebase can handle
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
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
            try Auth.auth().signOut() // Signs user out in the backend
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    // Delete's users details from firestore, and clears local session data
    func deleteAccount() async {
        
        let user = Auth.auth().currentUser!

        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            print("DEBUG: User data successfully deleted from Firestore.")
            
            try Auth.auth().signOut()
            print("DEBUG: User successfully signed out.")

            try await user.delete()
            print("DEBUG: Firebase Authentication user deleted.")

            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Error deleting user: \(error.localizedDescription)")
        }
    }
    
    // Fetches user information from Firestore using the current user's UID.
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
        if let user = self.currentUser {
            print("DEBUG: Current user is \(user)")
        } else {
            print("DEBUG: Current user is nil")
        }
    }
}
