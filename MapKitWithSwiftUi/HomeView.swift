//
//  HomeView.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 10/09/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Image("small_icon")
               
            Text("Integration of Map with SwiftUI")
            Button {
                print("Tap me to Launch Simple MapView Tapped")
            } label: {
                Text("Tap me to Launch Simple MapView").underline()
            }.padding(.vertical, 20)
            Button {
                print("Tap me to Launch Simple MapView Tapped")
            } label: {
                Text("Tap me to Launch Advanced MapView").underline()
            }.padding(.vertical, 20)
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
