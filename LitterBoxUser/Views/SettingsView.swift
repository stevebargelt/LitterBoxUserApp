//
//  SettingsView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/26/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var session = FirebaseSession()
    
    var body: some View {
                
            CustomButton(
                label: "Sign Out",
                action: self.session.logOut
                )
                .padding()
            
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()

    }
}

