//
//  CustomButton.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

// todo:
// add disabled, spinner, dark mode?

struct CustomButton : View {
    var label: String
    var action: () -> Void
    var loading: Bool = false
    
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
        }
            .padding()
            .background(loading ? Color.blue.opacity(0.3) : Color.blue)
            .cornerRadius(5)
    }
}

struct CustomButton_Previews : PreviewProvider {
    static var previews: some View {
        CustomButton(label: "Sign in", action: {
            print("Hello")
        })
    }
}
