//
//  AlarmImportName.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 15/09/21.
//

import SwiftUI

struct AlarmImportName: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var alarmModel: AlarmModel
    @AppStorage(StorageString.themeColor.rawValue) var themeColor: Color = .blue
    @AppStorage(StorageString.alarmSound.rawValue) var alarmSound: String = AlarmModel.notifications.Note.rawValue
    @State private var alarmName: String = ""
    @Binding var musicImportName: Bool
    
    var body: some View {
        ZStack {
            /// background for overlay
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.primary)
                .colorInvert()
                .frame(width: 350, height: 200, alignment: .center)
            
            VStack(alignment: .leading){
                Text("Choose alarm name")
                    .font(.headline)
                    .padding([.leading, .trailing, .top])
                    .padding(.leading)
                
                /// Alarm tone name field
                TextField(AlarmModel.shared.audioName, text: $alarmName)
                    .padding()
                    .padding(.leading)
                
                Button{
                    /// Setting default name
                    if alarmName.trimmingCharacters(in: .whitespaces) == "" {
                        alarmName = AlarmModel.shared.audioName
                    }
                    
                    /// adding to list
                    alarmModel.customAlarms.append(CustomAlarm(name: alarmName, url: AlarmModel.shared.audioName))
                    
                    /// Saving the list
                    alarmModel.save()
                    
                    /// Setting this tone as alarm tone
                    alarmSound = AlarmModel.shared.audioName
                    audioPlayer.playAudioLibrary()
                    
                    /// exiting th view
                    musicImportName = false
                    
                    AlarmModel.shared.audioName = ""
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 150, height: 50, alignment: .center)
                            .foregroundColor(themeColor)
                        Text("Add Alarm Tone")
                            .foregroundColor(themeColor.accessibleFontColor)
                    }
                }
                .padding()
                .padding(.leading)
            }
        }
    }
}

struct AlarmImportName_Previews: PreviewProvider {
    static var previews: some View {
        AlarmImportName(musicImportName: .constant(true))
            .environmentObject(AlarmModel())
            .environmentObject(AudioPlayer())
    }
}
