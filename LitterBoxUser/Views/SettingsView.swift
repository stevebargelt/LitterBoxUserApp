//
//  SettingsView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/26/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
            
        VStack {
//            Text("DisplayName \((self.session.session?.displayName)!)")
            Text("AppUser Email \(self.session.appUser?.email ?? "no email")")
            Text("Email \(self.session.user?.email ?? "no email")")
            Text("AppUser displayName \(self.session.appUser?.displayName ?? "no displayName")")
            Text("displayName \(self.session.user?.displayName ?? "no displayName")")
            if self.session.isLoggedIn! {
             Text("isLoggedIn True")
            } else {
             Text("isLoggedIn False")
            }
            CustomButton(
                    label: "Sign Out",
                    action: self.session.logOut
                    )
                .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()

    }
}

