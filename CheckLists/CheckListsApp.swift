//
//  CheckListsApp.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

@main
struct CheckListsApp: App {
    @StateObject private var modelData = ModelData()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .onAppear(){
                    modelData.load()
                }
        }
    }
}


/// Extension for foreground notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        /// To tell the app that we have finished processing
        completionHandler([.banner, .sound])
    }
    
    /// To manage what happens when user clicks the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        /// What to do
        let IDs = response.notification.request.identifier.split(separator: "+")
        
        ModelData.shared.listSelector = UUID(uuidString: String(IDs[0]))
        
        /// To tell the app that we have finished processing
        completionHandler()
    }
}
