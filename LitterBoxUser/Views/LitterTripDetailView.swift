//
//  LitterTripDetailView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct LitterTripDetailView: View {
      
    @State var litterTrip: LitterTrip
    @State var imageURL = ""
     
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            VStack {
                Text("When: \(litterTrip.formattedTimestamp)")
                Text("Probability \(litterTrip.formattedProbability)")
                Spacer()
                HStack {
                    Text("Direction \(litterTrip.Direction)")
                    Button(action: {
                        self.buttonPressed()
                    }) {
                        if litterTrip.Direction == "in" {
                            Image(systemName: "tray.and.arrow.down.fill").imageScale(.medium)
                        } else {
                            Image(systemName: "tray.and.arrow.up.fill").imageScale(.medium)
                        }
                    }
                }
                Text("Dir Probability \(litterTrip.formattedDirectionProbability)")
                Spacer()
                Text("Photo Path \(litterTrip.photoPath)")
                FirebaseImageView(imageURL: imageURL, width: 400, height: 400)
            }
            .padding()
            .onAppear(perform: loadImageFromFirebase)
        }
    }
    
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: litterTrip.photoPath)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
    

    func buttonPressed() {
        if litterTrip.Direction == "in" {
            litterTrip.Direction = "out"
            litterTrip.update(litterTrip)
        } else {
            litterTrip.Direction = "in"
            litterTrip.update(litterTrip)
        }
    }
}

struct LitterTripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LitterTripDetailView(litterTrip:
                                LitterTrip(Probability: 99.9, Direction: "in", DirectionProbability: 99.99,
                                            Photo: "https://images2.minutemediacdn.com/image/upload/c_crop,h_1347,w_2400,x_0,y_17/f_auto,q_auto,w_1100/v1572194246/shape/mentalfloss/87226-gettyimages-537121731.jpg",
                                            timestamp: nil))
    }
}
