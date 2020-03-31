//
//  LogIn.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    //MARK: Properties
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        VStack {
            Group {
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 75, height: 75)

                Text("Litter Box").font(.title).padding(.bottom)

                Text("The easiest way to know which cat is using the litterbox.")
                    .font(.subheadline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            //Spacer()
            Group {
                Divider()
                CustomInput(text: $email, name: "Email")
                    .padding()
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .modifier(InputModifier())
                    .padding([.leading, .trailing])

                CustomButton(
                    label: "Sign in",
                    action: logIn,
                    loading: false
                    )
                    .padding()
            }
            VStack {
                Divider()
                HStack(alignment: .center) {
                    Text("Don't have an account?")
                        .font(.footnote)
                    NavigationLink(destination: SignUp()) {
                        Text("Sign up.").font(.footnote)
                    }
                    }
                    .padding()
            }
        }
    }
    
    //MARK: Functions
    func logIn() {
        session.logIn(email: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
