//
//  SettingsView.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 01/09/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var audioPlayer = AudioPlayer()
    @EnvironmentObject var alarmModel: AlarmModel
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(StorageString.themeColor.rawValue) var themeColor = Color.blue
    @AppStorage(StorageString.colorSchemes.rawValue) var colorSchemes = AppColorScheme.system
    @AppStorage(StorageString.defaultCompleted.rawValue) var defaultCompleted: Bool = false
    @AppStorage(StorageString.snoozeTime.rawValue) var snoozeTime: Int = 5
    
    var checkLists: [CheckList]
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{
                    /// accent color picker
                    ColorPicker("Choose accent color", selection: $themeColor, supportsOpacity: false)
                    
                    /// dark, light mode picker
                    VStack(alignment: .leading) {
                        Text("Choose theme")
                        Picker("Choose theme", selection: $colorSchemes) {
                            ForEach(AppColorScheme.allCases) { scheme in
                                let name = "\(scheme)"
                                Text(name)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                Section {
                    /// Change whether to show completed by default
                    Toggle("Show Completed by default", isOn: $defaultCompleted)
                }
                
                Section{
                    /// Snooze time picker
                    Stepper("Snooze Time:\t \(snoozeTime) min",
                            onIncrement: {
                        snoozeTime += 1
                    }, onDecrement: {
                        if snoozeTime > 1 {
                            snoozeTime -= 1
                        }
                    })
                    
                    /// alarm tone picker
                    NavigationLink(
                        destination: AlarmPicker(checkLists: checkLists).environmentObject(audioPlayer).environmentObject(alarmModel).onDisappear(perform: audioPlayer.stopAudio)
                    )
                    {
                        Text("Alarm tone")
                    }
                }
                
                Section{
                    /// Github page link
                    ViewOnGithub(bgColor: themeColor)
                }
            }
            .navigationTitle("Settings")
            .toolbar(content: {
                /// Done Button
                Button(){
                    presentationMode.wrappedValue.dismiss()
                }label : {
                    Text("Done")
                }
            })
            .accentColor(themeColor)
        }
    }
}

enum AppColorScheme: Int, CaseIterable, Identifiable {
    case dark = 0
    case light = 1
    case system = 2
    
    var id: AppColorScheme {self}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(checkLists: [CheckList.data])
            .environmentObject(AlarmModel())
    }
}
