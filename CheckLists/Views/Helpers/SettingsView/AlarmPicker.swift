//
//  AlarmPicker.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 02/09/21.
//

import SwiftUI
import AVFoundation
import UniformTypeIdentifiers

struct AlarmPicker: View {
    @EnvironmentObject var alarmModel: AlarmModel
    @EnvironmentObject var audioPlayer: AudioPlayer
    @AppStorage(StorageString.alarmSound.rawValue) var alarmSound: String = AlarmModel.notifications.Note.rawValue
    @AppStorage(StorageString.colorSchemes.rawValue) var colorScheme = AppColorScheme.system
    @State private var musicImportInfo: Bool = false
    @State private var musicImport: Bool = false
    @State private var musicImportName: Bool = false
    
    var checkLists: [CheckList]
    
    var body: some View {
        
        /// for the audio name overlay
        ZStack {
            VStack(alignment: .leading) {
                List{
                    
                    /// Custom tones
                    if !alarmModel.customAlarms.isEmpty {
                        Section(header: Text("Custom")) {
                            ForEach(alarmModel.customAlarms){ customAlarm in
                                Button {
                                    alarmSound = customAlarm.url
                                    
                                    audioPlayer.playAudioLibrary()
                                }label: {
                                    HStack {
                                        Text(customAlarm.name)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if alarmSound == customAlarm.url {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.accentColor)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    /// Notification tones
                    Section(header: Text("Notification")) {
                        ForEach(AlarmModel.notifications.allCases) { sound in
                            Button{
                                alarmSound = sound.rawValue
                                
                                audioPlayer.playAudioBundle()
                                
                            }label: {
                                HStack{
                                    let name = "\(sound)"
                                    Text(name)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if alarmSound == sound.rawValue {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.accentColor)
                                    }
                                }
                            }
                        }
                    }
                    
                    /// ALarm Tones
                    Section(header: Text("Alarm")) {
                        ForEach(AlarmModel.alarm.allCases) { sound in
                            Button{
                                alarmSound = sound.rawValue
                                
                                audioPlayer.playAudioBundle()
                                
                            }label: {
                                HStack{
                                    let name = "\(sound)"
                                    Text(name)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if alarmSound == sound.rawValue {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.accentColor)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Pick a sound")
                .onChange(of: alarmSound) { value in
                    for checkList in checkLists {
                        for item in checkList.items {
                            
                            /// removing Notifications
                            AppNotification().remove(list: checkList, itemID: item.id)
                            
                            /// recreating Notifications
                            if item.haveDueDate {
                                AppNotification().schedule(list: checkList, item: item)
                            }
                        }
                    }
                }
                
                /// Import Audio Button
                audioImport
                    .padding()
                    .padding(.leading)
            }
            
            /// Set alarm Name overlay
            if musicImportName {
                Color.gray
                    .opacity(0.65)
                
                AlarmImportName(musicImportName: $musicImportName)
                    .environmentObject(alarmModel)
                    .environmentObject(audioPlayer)
                    .preferredColorScheme(setColorScheme(colorSchemes: colorScheme))
            }
        }
    }
    
    var audioImport: some View {
        Button{
            musicImportInfo.toggle()
        }label: {
            Label("Add Alarm Tone", systemImage: "plus.circle.fill")
        }
        /// Import Info sheet
        .sheet(isPresented: $musicImportInfo, content: {
            AlarmImportInfo()
                .preferredColorScheme(setColorScheme(colorSchemes: colorScheme))
        })
        .onChange(of: musicImportInfo, perform: { value in
            if !value {
                DispatchQueue.main.async {
                    musicImport.toggle()
                }
            }
        })
        /// File importer
        .fileImporter(isPresented: $musicImport,
                      allowedContentTypes: [UTType.wav, UTType.mpeg4Audio, UTType.aiff],
                      allowsMultipleSelection: false) { result in
            /// import was successful
            if case .success = result {
                do {
                    /// getting file url
                    let audioURL: URL = try result.get()[0]
                    
                    /// checking if we can access the file URL
                    if audioURL.startAccessingSecurityScopedResource() {
                        
                        /// Sending request to copy
                        AlarmImport().copyAudioFile(of: audioURL)
                    }
                }catch{
                    fatalError("File import error: \(error)")
                }
            }else {
                print("File import failed")
            }
        }
        /// Asking audio name
        /// Adding to customAlarms
        .onChange(of: musicImport) { value in
            if !value {
                DispatchQueue.main.async {
                    if AlarmModel.shared.audioName.trimmingCharacters(in: .whitespaces) != "" {
                        musicImportName.toggle()
                    }
                }
            }
        }
    }
}

struct AlarmPicker_Previews: PreviewProvider {
    static var previews: some View {
        AlarmPicker(checkLists: [CheckList.data])
            .environmentObject(AlarmModel())
            .environmentObject(AudioPlayer())
    }
}
