//
//  CatDetailView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct CatDetailView: View {
    
    @ObservedObject var session = FirebaseSession()
    @State var complete = false
    @State var uploadPresented = false
    @State var cat: Cat
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            VStack {
                Text(cat.name)
                Spacer()
                NavigationLink(destination: LitterTripsView(cat: cat)) {
                    Text("Litter Trips")
                }
                Spacer()
                FirebaseImageView(imageURL: cat.photo, width: 300, height: 300)
                Button(action: { self.uploadPresented.toggle() }) {
                    Text("Upload Image").font(.title).bold()
                }.sheet(isPresented: $uploadPresented) {
                    imagePicker(shown: self.$uploadPresented, cat: self.$cat)
                    }
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
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
        }
        .padding()
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

struct CatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailView(cat: Cat(name: "TestBear", color: "Black", age: 7,
                               photo: "gs://mycats-ba2ef.appspot.com/catimages/Bear",
                               createdTime: nil))
    }
}
