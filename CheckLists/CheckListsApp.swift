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
    
    ///foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

/// Extension for swipe buttons
extension View {
    func addButtonActions(leadingButtons: [SwipeButton], trailingButtons: [SwipeButton], onClick: @escaping (SwipeButton) -> Void) -> some View {
        self.modifier(SwipeContainer(leadingButtons: leadingButtons, trailingButtons: trailingButtons, onCLick: onClick))
    }
}
