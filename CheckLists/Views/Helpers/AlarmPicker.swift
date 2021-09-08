//
//  AlarmPicker.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 02/09/21.
//

import SwiftUI
import AVFoundation

struct AlarmPicker: View {
    @AppStorage(StorageString.alarmSound.rawValue) var alarmSound: String = alarmSounds.notifications.Note.rawValue
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    var checkLists: [CheckList]
    
    var body: some View {
        List{
            Section(header: Text("Notification")) {
                ForEach(alarmSounds.notifications.allCases) { sound in
                    Button{
                        alarmSound = sound.rawValue
                        
                        audioPlayer.playAudio()
                        
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
            Section(header: Text("Alarm")) {
                ForEach(alarmSounds.alarm.allCases) { sound in
                    Button{
                        alarmSound = sound.rawValue
                        
                        audioPlayer.playAudio()
                        
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
    }
}

struct alarmSounds {
    enum notifications: String, CaseIterable, Identifiable {
        case Note = "iPhone-Note-SMS.m4r"
        case Whoosh = "mixkit-woosh-wind-1168.wav"
        case Bell = "mixkit-bell-notification-933.wav"
        case Achievement = "mixkit-achievement-bell-600.wav"
        case Mystery = "mixkit-bells-of-mystery-581.wav"
        case Reward = "mixkit-correct-answer-reward-952.wav"
        case Happy = "mixkit-happy-bells-notification-937.wav"
        case DingDong = "mixkit-home-standard-ding-dong-109.wav"
        case Musical = "mixkit-musical-reveal-961.wav"
        case Higher = "mixkit-raising-me-higher-34.mp3"
        case SchoolBell = "mixkit-school-calling-bell-580.wav"
        case Melody = "mixkit-melodical-flute-music-notification-2310.wav"
        case Retro = "mixkit-retro-game-notification-212.wav"
        case Telephone = "mixkit-vintage-telephone-ringtone-1356.wav"
        case Roar = "mixkit-wild-lion-animal-roar-6.wav"
        
        var id: String { self.rawValue }
    }
    
    enum alarm: String, CaseIterable, Identifiable {
        case Guitar = "mixkit-oh-779.mp3"
        case Dance = "mixkit-dance-with-me-3.mp3"
        case Dreaming = "mixkit-dreaming-big-31.mp3"
        case Life = "mixkit-life-is-a-dream-837.mp3"
        case Retro = "mixkit-retro-game-emergency-alarm-1000.wav"
        case GameShow = "mixkit-game-show-suspense-waiting-667.wav"
        case Rain = "mixkit-light-rain-loop-2393.mp3"
        case BirdsChirping = "mixkit-little-birds-singing-in-the-trees-17.mp3"
        case Marimba = "mixkit-marimba-waiting-ringtone-1360.wav"
        
        var id: String {self.rawValue}
    }
}

struct AlarmPicker_Previews: PreviewProvider {
    static var previews: some View {
        AlarmPicker(checkLists: [CheckList.data])
            .environmentObject(AudioPlayer())
    }
}
