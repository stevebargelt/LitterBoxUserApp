//
//  NewCatView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct NewCatView: View {
    
    @State private var newCat = Cat()
    @ObservedObject var session = FirebaseSession()
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            CustomInput(text: $newCat.name, name: "Name")
                .padding()
            CustomInput(text: $newCat.color, name: "Color")
                .padding()
                .autocapitalization(.none)
            Stepper(value: $newCat.age, in: 1...30) {
                Text("Age: \(newCat.age)")
            }
//            CustomInput(text: $newCat.photo, name: "Photo URL")
//                .padding()
            CustomButton(
                label: "Add Cat",
                action: addCat
                )
                .padding()
            .disabled(disableForm)

        }
        .padding()
    }
    
    var disableForm: Bool {
        newCat.name.isEmpty ||
        newCat.color.isEmpty
    }
    
    
    func addCat() {
        session.addCat(newCat)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewCatView_Previews: PreviewProvider {
    static var previews: some View {
        NewCatView()
    }
}
