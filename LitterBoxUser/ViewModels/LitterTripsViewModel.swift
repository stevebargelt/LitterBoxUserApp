//
//  LitterTripsViewModel.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/14/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import FirebaseFirestore

class LitterTripsViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var litterTrips: [LitterTrip] = []

    func getLitterTrips() {
        // Remove previously data to prevent duplicate data
        self.litterTrips.removeAll()
        self.db.collection("litterTrips")
            .order(by: "timestamp", descending: true)
            .limit(to: 25)
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents \(err)")
                }
                if let querySnapshot = querySnapshot {
                    self.litterTrips = querySnapshot.documents.compactMap { document -> LitterTrip? in
                        try? document.data(as: LitterTrip.self)
            }
          }
        }
      }
    
    func remove(_ litterTrip: LitterTrip) {
        if let litterTripID = litterTrip.id {
            db.collection("litterTrips").document(litterTripID).delete { (error) in
                if let error = error {
                    print("Error removing Litter Trip document: \(error.localizedDescription)")
                }
            }
        }
    }
}
