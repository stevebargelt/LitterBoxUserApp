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
import FirebaseFirestore

class FirebaseSession: ObservableObject {
    
    @Published var session: User?
    @Published var isLoggedIn: Bool?
    @Published var cats: [Cat] = []

    var catsPath: String = "cats"
    
    var db = Firestore.firestore()
        
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.isLoggedIn = true
                self.loadData()
            } else {
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() {
            try! Auth.auth().signOut()
            self.isLoggedIn = false
            self.session = nil

    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    private func loadData() {
      db.collection(catsPath)
        .order(by: "createdTime")
        .addSnapshotListener { (querySnapshot, error) in
          if let querySnapshot = querySnapshot {
            self.cats = querySnapshot.documents.compactMap { document -> Cat? in
              try? document.data(as: Cat.self)
            }
          }
        }
    }
    
    func addCat(_ cat: Cat) {
        do {
          let _ = try db.collection(catsPath).addDocument(from: cat)
        }
        catch {
          print("There was an error while trying to save the cat \(error.localizedDescription).")
        }
      }

    func updateCat(_ cat: Cat) {
        if let catID = cat.id {
            do {
                try db.collection(catsPath).document(catID).setData(from: cat)
            }
            catch {
                print("There was an error while trying to update a cat \(error.localizedDescription).")
            }
        }
    }

    
    func removeCat(_ cat: Cat) {
        if let catID = cat.id {
            db.collection(catsPath).document(catID).delete { (error) in
                if let error = error {
                    print("Error removing cat document: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
