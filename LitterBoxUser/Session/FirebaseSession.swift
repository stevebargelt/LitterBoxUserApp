//
//  FirebaseSession.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
    
    @Published var appUser: AppUser?
    @Published var user: User?
    @Published var isLoggedIn: Bool?
    
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, userFromFirebase) in
            if let user = userFromFirebase {
                self.appUser = AppUser(uid: user.uid, displayName: user.displayName, email: user.email)
                self.user = user
                self.isLoggedIn = true
            } else {
                self.isLoggedIn = false
                self.appUser = nil
            }
        }
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() {
            try! Auth.auth().signOut()
            self.isLoggedIn = false
            self.appUser = nil

    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
}
