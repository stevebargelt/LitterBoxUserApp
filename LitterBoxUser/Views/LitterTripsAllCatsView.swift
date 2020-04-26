//
//  LitterTripsAllCats.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/8/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct LitterTripsAllCatsView: View {
    
    @ObservedObject var session = FirebaseSession()
    @ObservedObject var litterTripsVM = LitterTripsViewModel()
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            Group {
                if session.session != nil {
                    VStack {
                        List {
                            ForEach(self.litterTripsVM.litterTrips) { litterTrip in
                                NavigationLink(destination: LitterTripDetailView(litterTrip: litterTrip)) {
                                    HStack {
                                        Text(litterTrip.CatName)
                                        Text(litterTrip.formattedTimestamp)
                                        Text(litterTrip.Direction)
                                    }
                                }
                            }.onDelete(perform: delete)
                        }
                    }
                }
                else {
                    LoginView()
                    .navigationBarItems(trailing: Text(""))
                }
            }
            .navigationBarTitle(Text("Litter Trips"))
            .padding()
        }
        .onAppear {
            self.getUser()
            self.litterTripsVM.getLitterTrips()
        }
    }

    
    func getUser() {
        if ProcessInfo.processInfo.arguments.contains("--uitesting") {
            // if we are running UI tests logout to get fresh session
            session.logOut()
        }
        session.listen()
        Messaging.messaging().subscribe(toTopic: "littertrips") { error in
          print("Subscribed to littertrips topic")
        }
    }
    
    func delete(at offsets: IndexSet){
        for index in offsets {
            let litterTrip = litterTripsVM.litterTrips[index]
            litterTripsVM.remove(litterTrip)
        }
    }
        
}

struct LitterTripsAlLCatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}

