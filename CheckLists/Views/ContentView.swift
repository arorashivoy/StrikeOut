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
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("themeColor") var themeColor = Color.blue
    @AppStorage("colorSchemes") var colorSchemes: appColorScheme = appColorScheme.system
    
    var body: some View {
        ListSelection()
            .environmentObject(modelData)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(ModelData())
        }
    }
}
