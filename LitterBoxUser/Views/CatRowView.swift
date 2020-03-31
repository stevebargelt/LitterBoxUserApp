//
//  CatRowView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI

struct CatRowView: View {
    
    var cat: Cat
    
    var body: some View {
        HStack {
            FirebaseImageView(imageURL: cat.photo, width: 50, height: 50)
            Text(cat.name)
            Spacer()
            Text(cat.color)
        }
    }
}

struct CatRow_Preview: PreviewProvider {
    static var previews: some View {
        CatRowView(cat: Cat(name: "TestBear", color: "Black", age: 7,
        photo: "gs://mycats-ba2ef.appspot.com/catimages/Bear",
        createdTime: nil))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
