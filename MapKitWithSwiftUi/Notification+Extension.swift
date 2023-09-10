//
//  Notification+Extension.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 11/09/23.
//

import UIKit
import Foundation

enum NotificationData: String {
    case reCenterMapLocationData
}

extension Notification.Name {
    static let reCenterMapLocation = Notification.Name("reCenterMapLocation")
}

