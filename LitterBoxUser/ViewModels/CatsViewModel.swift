//
//  CatsViewModel.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/14/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import FirebaseFirestore

class CatsViewModel : ObservableObject {
    
    @Published var cats: [Cat] = []

    var catsPath: String = "cats"
    
    var db = Firestore.firestore()
        
    func getCats() {
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
    
    func remove(_ cat: Cat) {
        if let catID = cat.id {
            db.collection(catsPath).document(catID).delete { (error) in
                if let error = error {
                    print("Error removing cat document: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
