//
//  Cat.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum CatColor: Int, Codable {
    case White
    case Black
    case Ginger
    case Gray
    case Cream
    case Brown
    case Cinnamon
    case Fawn
}

enum CatCoatPattern: Int, Codable {
    case Solid
    case BiColour
    case Tabby
    case Tortoiseshell
    case Calico
    case ColourPoint
}

struct Cat : Codable, Identifiable {
    
    @DocumentID var id: String?
    var name : String
    var color : String
    //var color: CatColor
    //var coatPattern: CatCoatPattern
    var age: Int
    var photo : String
    @ServerTimestamp var createdTime: Timestamp?
    
    
    init(name: String = "",
         color: String = "",
         age: Int = 0,
         photo: String = "",
         createdTime: Timestamp? = nil) {
        
            self.name = name
            self.color = color
            self.age = age
            self.photo = photo
            self.createdTime = createdTime
    }

}
