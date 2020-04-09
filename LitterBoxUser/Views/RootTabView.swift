//
//  RootTabView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 4/8/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Cats")
                }
            LitterTripsAllCatsView()
                .tabItem{
                    Image(systemName: "tray.and.arrow.down")
                    Text("Litter Trips")
            }
        //.accentColor(Color("B1"))

        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}

