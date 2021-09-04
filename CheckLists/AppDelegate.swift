//
//  AppDelegate.swift
//  CheckLists
//
//  Created by Shivoy Arora on 01/08/21.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
//    var modelData = ModelData()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
