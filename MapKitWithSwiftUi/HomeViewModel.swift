//
//  HomeViewModel.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 10/09/23.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: ObservableObject {
    var moveToNextViewType: MoveToNextViewTypeFromHomeView { get set }
    var showNextUIOfNavigationFlow: Bool { get set }
}

enum MoveToNextViewTypeFromHomeView {
    case moveToSimpleMapView
    case moveToAdvancedMapView
    case moveToMoreAdvancedMapView
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var moveToNextViewType: MoveToNextViewTypeFromHomeView = .moveToSimpleMapView
    @Published var showNextUIOfNavigationFlow: Bool = false
}

