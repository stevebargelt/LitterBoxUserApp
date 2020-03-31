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
      
    var litterTrip: LitterTrip
    @State var imageURL = ""
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            VStack {
                Text("When: \(litterTrip.formattedTimestamp)")
                Text("Probability \(litterTrip.formattedProbability)")
                Spacer()
                Text("Direction \(litterTrip.Direction)")
                Text("Dir Probability \(litterTrip.formattedDirectionProbability)")
                Spacer()
                Text("Photo Path \(litterTrip.photoPath)")
                FirebaseImageView(imageURL: imageURL, width: 400, height: 400)
//                WebImage(url: URL(string: litterTrip.photoURL ))
//                    .onSuccess { image, cacheType in
//                        // Success
//                    }
//                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
//                    .placeholder(Image(systemName: "photo")) // Placeholder Image
//                    // Supports ViewBuilder as well
//                    .placeholder {
//                        Rectangle().foregroundColor(.gray)
//                    }
//                    .indicator(.activity) // Activity Indicator
//                    .animation(.easeInOut(duration: 0.5)) // Animation Duration
//                    .transition(.fade) // Fade Transition
//                    .scaledToFit()
//                    .frame(width: 300, height: 300, alignment: .center)
                
//                Button(action: {
//                    self.buttonPressed()
//                }) {
//                    if self.complete == true {
//                        Image(systemName: "checkmark").imageScale(.medium)
//                    } else {
//                        Image(systemName: "xmark").imageScale(.medium)
//                    }
//                }
//                .onAppear() {
//                    self.setupButton()
//                }
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
    
//    func setupButton() {
//        if cat.isComplete == "true" {
//            complete = true
//        } else {
//            complete = false
//        }
//    }
//
//    func buttonPressed() {
//        if complete == true {
//            self.complete = false
//            self.session.updateTODO(key: todo.key, todo: todo.todo, isComplete: "false")
//            print("buttonpressed ran, should set complete, complete is: \(String(describing: self.complete))")
//        } else {
//            self.complete = true
//            self.session.updateTODO(key: todo.key, todo: todo.todo, isComplete: "true")
//            print("buttonpressed ran, should set incomplete, complete is \(String(describing: self.complete))")
//        }
//    }
}

struct LitterTripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LitterTripDetailView(litterTrip:
                                LitterTrip(Probability: 99.9, Direction: "in", DirectionProbability: 99.99,
                                            Photo: "https://images2.minutemediacdn.com/image/upload/c_crop,h_1347,w_2400,x_0,y_17/f_auto,q_auto,w_1100/v1572194246/shape/mentalfloss/87226-gettyimages-537121731.jpg",
                                            timestamp: nil))
    }
}
