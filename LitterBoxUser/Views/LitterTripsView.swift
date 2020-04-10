//
//  LitterTripsView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct LitterTripsView: View {
    
     @State var litterTrips: [LitterTrip] = []
    
    let db = Firestore.firestore()
    var cat: Cat
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    List {
                        ForEach(self.litterTrips) { litterTrip in
                            NavigationLink(destination: LitterTripDetailView(litterTrip: litterTrip)) {
                                HStack {
                                    Text(litterTrip.formattedTimestamp)
                                    Text(litterTrip.formattedProbability)
                                    Spacer()
                                    Text(litterTrip.Direction)
                                    Text(litterTrip.formattedDirectionProbability)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Litter Trips"), displayMode: .inline)
            .padding()
        }
        .onAppear {
            self.getLitterTrips()
        }
    }
    
    func getLitterTrips() {
        // Remove previously data to prevent duplicate data
        self.litterTrips.removeAll()
        self.db.collection("litterTrips")
            .whereField("CatName", isEqualTo: self.cat.name)
            .order(by: "timestamp", descending: true)
        .limit(to: 30)
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
        
}

struct LitterTripsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

