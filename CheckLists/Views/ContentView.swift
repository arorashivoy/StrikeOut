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
            .preferredColorScheme(setColorScheme(colorSchemes: colorSchemes))
            .onChange(of: scenePhase, perform: { phase in
                if phase == .inactive {
                    modelData.save()
                }
            })
    }
}

/// To set color scheme which the user chooses
/// - Parameter colorSchemes: Value selected from the picker in Settings
/// - Returns: colorScheme
func setColorScheme(colorSchemes: AppColorScheme) -> ColorScheme? {
    switch colorSchemes {
    case .dark:
        return .dark
    case .light:
        return .light
    case .system:
        return nil
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
    case snoozeTime
}

struct SetButton: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(bgColor.accessibleFontColor)
            .padding()
            .padding([.leading, .trailing], 5)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
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
