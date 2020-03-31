//
//  SignUp.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI


struct SignUp: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        Group {
            VStack {
                VStack {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .resizable()
                        .frame(width: 75, height: 75)

                    Text("Litter Box").font(.title).padding(.bottom)

                    Text("The easiest way to know which cat is using the litterbox.")
                        .font(.subheadline)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }.padding(.bottom)
                VStack{
                    Text("Create an account")
                        .font(.title)
                    CustomInput(text: $email, name: "Email")
                        .padding()
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .modifier(InputModifier())
                        .padding([.leading, .trailing])
                    CustomButton(
                        label: "Creat Account",
                        action: signUp,
                        loading: false
                        )
                        .padding()
                }
            }
        }
        .padding()
    }
    
    func signUp() {
        if !email.isEmpty && !password.isEmpty {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    print("Error")
                } else {
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
