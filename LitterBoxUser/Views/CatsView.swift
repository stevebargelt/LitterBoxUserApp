//
//  ContentView.swift
//  LitterBoxUser
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import SwiftUI
import Firebase

struct CatsView: View {
    
    @ObservedObject var catsVM = CatsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                    VStack {
                        NavigationLink(destination: NewCatView()) {
                            Text("Add Cat")
                        }
                        
                        List {
                            ForEach(self.catsVM.cats) { cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    CatRowView(cat: cat)
                                }
                            }.onDelete(perform: delete)
                        }

                    }
                    .onAppear {
                        self.catsVM.getCats()
                    }
            }
            .navigationBarTitle(Text("Cats"))
            .padding()
        }
    }
    
    
    func delete(at offsets: IndexSet){
        for index in offsets {
            let cat = catsVM.cats[index]
            catsVM.remove(cat)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}

