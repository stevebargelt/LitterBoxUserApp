//
//  CustomInput.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct InputModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .border(Color(red: 0, green: 0, blue: 0, opacity: 0.15), width: 1)
    }
}

struct CustomInput : View {
    @Binding var text: String
    var name: String
    
    var body: some View {
        TextField(name, text: $text)
            .modifier(InputModifier())
    }
}

struct CustomInput_Previews : PreviewProvider {
    
    static var previews: some View {
        CustomInput(text: .constant(""), name: "Some name")
            .padding()
    }
}
