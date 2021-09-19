//
//  AppDelegate.swift
//  CheckLists
//
//  Created by Shivoy Arora on 01/08/21.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    /// Tell the delegate that the app launch process has begun but the state restoration has not yet occured
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        configureNotiCategory()
        
        return true
    }
    
    /// To configure Notification Action Button
    private func configureNotiCategory() {
        /// Define Action
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE",
                                                title: "Snooze",
                                                options: UNNotificationActionOptions(rawValue: 0))
        
        /// Define the notification type
        let alarmCategory = UNNotificationCategory(identifier: "ALARM",
                                                   actions: [snoozeAction],
                                                   intentIdentifiers: [],
                                                   hiddenPreviewsBodyPlaceholder: "",
                                                   options: .customDismissAction)
        
        /// Register the notification type
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
}
