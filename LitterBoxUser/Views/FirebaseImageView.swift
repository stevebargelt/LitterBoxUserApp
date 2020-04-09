//
//  FirebaseImageView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseStorage

struct FirebaseImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    var frameWidth: CGFloat?, frameHeight: CGFloat?
    
    init(imageURL: String, width: CGFloat?, height: CGFloat?) {
        imageLoader = DataLoader(urlString:imageURL)
        frameWidth = width
        frameHeight = height
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .animation(.easeInOut(duration: 0.5))
//                .transition(.fade) // Fade Transition
                .scaledToFit()
                .frame(width: frameWidth, height: frameHeight, alignment: .center)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

class DataLoader: ObservableObject {
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

struct FirebaseImageView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseImageView(imageURL: "https://firebasestorage.googleapis.com/v0/b/mycats-ba2ef.appspot.com/o/catimages%2FBear?alt=media&token=f71e720c-4308-4a82-9d25-48febc5f5b7e", width: 50, height: 50)
   }
}
