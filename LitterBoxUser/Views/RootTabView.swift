//
//  RootTabView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/8/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Firebase

struct RootTabView: View {
    
    @ObservedObject var session = FirebaseSession()
    
    var body: some View {
        Group {
            if session.session != nil {
                TabView{
                    LitterTripsAllCatsView()
                        .tabItem{
                            Image(systemName: "tray.and.arrow.down")
                            Text("Litter Trips")
                        }
                    ContentView()
                        .tabItem{
                            Image(systemName: "person")
                            Text("Cats")
                        }
                    SettingsView()
                        .tabItem{
                            Image(systemName: "person.crop.circle")
                            Text("Settings")
                        }
                }
            }
            else {
                LoginView()
                .navigationBarItems(trailing: Text(""))
            }
        }
        .onAppear {
            self.getUser()
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
    
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}


