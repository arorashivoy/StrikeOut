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
    @AppStorage(StorageString.alarmSound.rawValue) var alarmSound: String = alarmSounds.notifications.Note.rawValue
    
    func requestPermission() -> Void {
        /// To request permission to show notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func schedule(list: CheckList, item: CheckList.Items) -> Void {
        
        ///to only send notification when not completed
        if !item.isCompleted {
            let content = UNMutableNotificationContent()
            content.title = item.itemName
            content.body = item.note
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: alarmSound))
//            content.sound = UNNotificationSound.default
            
            /// getting date components
            let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute],
                                                             from: item.dueDate!)
            
            /// when to show the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            /// requesting the notification
            let ID = "\(list.id.uuidString)+\(item.id.uuidString)"
            let request = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)
            
            /// add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func remove(list: CheckList, itemID: CheckList.Items.ID) -> Void {
        let ID = "\(list.id.uuidString)+\(itemID.uuidString)"
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ID])
    }
    
}
