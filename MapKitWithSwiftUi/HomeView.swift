//
//  HomeView.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 10/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    
    func buildView() -> some View {
        if viewModel.moveToNextViewType == .moveToSimpleMapView {
            return AnyView(SimpleMapView()).edgesIgnoringSafeArea(.all)
        } else if viewModel.moveToNextViewType == .moveToAdvancedMapView {
            return AnyView(AdvancedMapView()).edgesIgnoringSafeArea(.all)
        } else if viewModel.moveToNextViewType == .moveToMoreAdvancedMapView {
            return AnyView(AdvancedMapView()).edgesIgnoringSafeArea(.all)
        } else {
            return AnyView(HomeView()).edgesIgnoringSafeArea(.all)
        }
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                NavigationLink(
                    destination: buildView(), isActive: $viewModel.showNextUIOfNavigationFlow
                ) {
                    EmptyView()
                }.isDetailLink(false)
                
                Image("small_icon")
                
                Text("Integration of Map with SwiftUI").padding(.top, 10).padding(.bottom, 30)
                Button {
                    print("Tap me to Launch Simple MapView Tapped")
                    viewModel.moveToNextViewType = .moveToSimpleMapView
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Simple MapView").underline()
                }.padding(.vertical, 10)
                Button {
                    print("Tap me to Launch Advanced MapView Tapped")
                    viewModel.moveToNextViewType = .moveToAdvancedMapView
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Advanced MapView").underline()
                }.padding(.vertical, 10)
                Button {
                    print("Tap me to Launch More Advanced MapView Tapped")
                    viewModel.moveToNextViewType = .moveToMoreAdvancedMapView
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch More Advanced MapView").underline()
                }.padding(.vertical, 10)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
