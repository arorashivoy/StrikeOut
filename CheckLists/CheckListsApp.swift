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
    @StateObject private var alarmModel = AlarmModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(alarmModel)
                .onAppear(){
                    modelData.load()
                    alarmModel.load()
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
        let notiID = response.notification.request.identifier
        let notiTitle = response.notification.request.content.title
        let notiBody = response.notification.request.content.body
        let notiSound = response.notification.request.content.sound
        
        ModelData.shared.listSelector = UUID(uuidString: String(IDs[0]))
        
        switch response.actionIdentifier {
        case "SNOOZE":
            /// Setting up new Notification after 5 min
            let content = UNMutableNotificationContent()
            content.title = notiTitle
            content.body = notiBody
            content.sound = notiSound
            content.categoryIdentifier = "ALARM"
            
            var timeInterval = UserDefaults.standard.integer(forKey: StorageString.snoozeTime.rawValue)
            
            if timeInterval == 0 {
                timeInterval = 5
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval * 60) , repeats: false)
            let request = UNNotificationRequest(identifier: notiID, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
            break
            
        default:
            ModelData.shared.listSelector = UUID(uuidString: String(IDs[0]))
            
            break
        }
        
        /// To tell the app that we have finished processing
        completionHandler()
    }
}
