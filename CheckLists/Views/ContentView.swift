//
//  ContentView.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var alarmModel: AlarmModel
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(StorageString.themeColor.rawValue) var themeColor = Color.blue
    @AppStorage(StorageString.colorSchemes.rawValue) var colorSchemes: AppColorScheme = AppColorScheme.system
    
    var body: some View {
        ListSelection()
            .environmentObject(modelData)
            .environmentObject(alarmModel)
            .accentColor(themeColor)
            .preferredColorScheme(setColorScheme())
            .onChange(of: scenePhase, perform: { phase in
                if phase == .inactive {
                    modelData.save()
                }
            })
    }
    
    /// To set color scheme which the user chooses
    /// - Returns: colorScheme
    func setColorScheme() -> ColorScheme? {
        switch colorSchemes {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}


/// Keys for @AppStorage wrapper
enum StorageString: String {
    case themeColor
    case colorSchemes
    case alarmSound
    case defaultCompleted
    case notiAsked
    case compAsked
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(AlarmModel())
                .environmentObject(ModelData())
        }
    }
}
