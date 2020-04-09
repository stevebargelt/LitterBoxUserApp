//
//  LitterTrip.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

struct LitterTrip : Codable, Identifiable {
    
    @DocumentID var id: String?
    var CatName: String
    var Probability: Float
    var Direction: String
    var DirectionProbability: Float
    var Photo : String
    @ServerTimestamp var timestamp: Timestamp?
    
    var formattedTimestamp:String{
        let df = DateFormatter()
        df.dateFormat = "yyy-MM-dd hh:mm"
        return df.string(from: (timestamp?.dateValue())!)
    }
    
    /// Returns total as a string in $0.00 format
    var formattedProbability:String{
        String(format:"%3.2f",Probability)
    }
    var formattedDirectionProbability:String{
        String(format:"%3.2f",DirectionProbability)
    }

    var photoPath:String {
        let yourTargetUrl = URL(string:Photo)!
        let components = URLComponents(url: yourTargetUrl, resolvingAgainstBaseURL: false)!
        let parts = components.path.components(separatedBy: "/")
        //return "0:\(parts[0]) 1:\(parts[1]) 2:\(parts[2]) 3:\(parts[3])"
        return "\(parts[2])/\(parts[3])"
    }
    
    init(CatName: String = "",
         Probability: Float = 0,
         Direction: String = "",
         DirectionProbability: Float = 0,
         Photo: String = "",
         timestamp: Timestamp? = nil) {
            self.CatName = CatName
            self.Probability = Probability
            self.Direction = Direction
            self.DirectionProbability = DirectionProbability
            self.Photo = Photo
            self.timestamp = timestamp
    }

}
