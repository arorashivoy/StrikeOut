//
//  AppNotification.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import Foundation
import SwiftUI
import UserNotifications
import NotificationCenter

class AppNotification {
    
    init() {
        /// To request permission to show notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    func schedule(item: CheckList.Items) -> Void {
        
        ///to only send notification when not completed
        if !item.isCompleted {
            let content = UNMutableNotificationContent()
            content.title = item.itemName
            content.body = item.note
            content.sound = UNNotificationSound.default
            
            /// getting date components
            let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute],
                                                             from: item.dueDate!)
            
            /// when to show the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            /// requesting the notification
            let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
            
            /// add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func remove(ID: CheckList.Items.ID) -> Void {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ID.uuidString])
    }
    
}
