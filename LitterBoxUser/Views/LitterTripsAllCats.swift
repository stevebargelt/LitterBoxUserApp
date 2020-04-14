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
    
   // @State var litterTrips: [LitterTrip] = []
    
    @ObservedObject var litterTripsVM = LitterTripsViewModel()
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            Group {
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
            .navigationBarTitle(Text("Litter Trips"))
            .padding()
        }
        .onAppear {
            self.litterTripsVM.getLitterTrips()
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
        ContentView()
    }
}

