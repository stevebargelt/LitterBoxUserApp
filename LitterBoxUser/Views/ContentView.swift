//
//  ContentView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var session = FirebaseSession()
    @ObservedObject var catsVM = CatsViewModel()
    
    @State var showingProfile = false
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if session.session != nil {
                    VStack {
                        NavigationLink(destination: NewCatView()) {
                            Text("Add Cat")
                        }
                        
                        List {
                            ForEach(self.catsVM.cats) { cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    CatRowView(cat: cat)
                                }
                            }.onDelete(perform: delete)
                        }
                        .navigationBarItems(trailing: profileButton)
                        .sheet(isPresented: $showingProfile) {
                            Text("User Profile")
                            CustomButton(
                                label: "Sign Out",
                                action: self.session.logOut
                                )
                                .padding()
                        }
                    }
                    .onAppear {
                        self.catsVM.getCats()
                    }
                } else {
                    LoginView()
                    .navigationBarItems(trailing: Text(""))
                }
            }
//            .navigationBarHidden(true)
            .navigationBarTitle(Text("Cats"))
            .padding()
        }
        .onAppear(perform: getUser)
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
            let cat = catsVM.cats[index]
            catsVM.remove(cat)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

