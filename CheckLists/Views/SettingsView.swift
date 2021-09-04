//
//  SettingsView.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 01/09/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var audioPlayer = AudioPlayer()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("themeColor") var themeColor = Color.blue
    @AppStorage("colorSchemes") var colorSchemes: appColorScheme = appColorScheme.system
    
    var body: some View {
        NavigationView{
            Form{
                
                
                // change labels
                
                
                Section{
                    /// accent color picker
                    ColorPicker("Choose accent color", selection: $themeColor)
                    
                    /// dark, light mode picker
                    VStack(alignment: .leading) {
                        Text("Choose theme")
                        Picker("Choose theme", selection: $colorSchemes) {
                            ForEach(appColorScheme.allCases) { scheme in
                                let name = "\(scheme)"
                                Text(name)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                Section{
                    /// alarm tone picker
                    NavigationLink(
                        destination: AlarmPicker().environmentObject(audioPlayer).onDisappear(perform: audioPlayer.stopAudio)
                    )
                    {
                        Text("Alarm tone picker")
                    }
                }
                /// donate link
                DonateLink(bgColor: .accentColor)
            }
            .navigationTitle("Settings")
            .toolbar(content: {
                /// Done Button
                Button(){
                    presentationMode.wrappedValue.dismiss()
                }label : {
                    Text("Done")
                        .foregroundColor(.red)
                }
            })
            .accentColor(themeColor)
        }
    }
}

enum appColorScheme: Int, CaseIterable, Identifiable {
    case dark = 0
    case light = 1
    case system = 2
    
    var id: appColorScheme {self}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
