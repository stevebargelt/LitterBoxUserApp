//
//  LitterTripsAllCats.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/8/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct LitterTripsAllCatsView: View {
    
     @State var litterTrips: [LitterTrip] = []
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    List {
                        ForEach(self.litterTrips) { litterTrip in
                            NavigationLink(destination: LitterTripDetailView(litterTrip: litterTrip)) {
                                HStack {
                                    Text(litterTrip.CatName)
                                    Text(litterTrip.formattedTimestamp)
                                    //Text(litterTrip.formattedProbability)
                                    Text(litterTrip.Direction)
                                    //Text(litterTrip.formattedDirectionProbability)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        //.navigationBarTitle(Text("Litter Trips"))
        .onAppear {
            self.getLitterTrips()
        }
    }
    
    
    func getLitterTrips() {
        // Remove previously data to prevent duplicate data
        self.litterTrips.removeAll()
        self.db.collection("test2")
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
    
//    //TODO: we need to rearrange data to be flat... this is not the way we want to do this
//    //TODO: and should be a snapshot listener to auto update
//    func getLitterTrips2() {
//        // Remove previously data to prevent duplicate data
//        self.litterTrips.removeAll()
//        self.db.collection("test").getDocuments{ (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    document.collection("LitterTrips")
//                        .order(by: "timestamp", descending: true)
//                        .getDocuments{ (querySnapshot2, err2) in
//                        
//                        }
//                }
//                }
//        }
//    }
//            .document(self.cat.id!).collection("LitterTrips")
//            .order(by: "timestamp", descending: true)
//        .addSnapshotListener { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents \(err)")
//            }
//            if let querySnapshot = querySnapshot {
//                self.litterTrips = querySnapshot.documents.compactMap { document -> LitterTrip? in
//                    try? document.data(as: LitterTrip.self)
//            }
//          }
//        }
//      }
        
}

struct LitterTripsAlLCatsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

