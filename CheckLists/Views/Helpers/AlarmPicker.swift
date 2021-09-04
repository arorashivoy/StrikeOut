//
//  AlarmPicker.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 02/09/21.
//

import SwiftUI
import AVFoundation

struct AlarmPicker: View {
    @AppStorage("alarmSound") var alarmSound: String = alarmSounds.notifications.Note.rawValue
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    var body: some View {
        List{
            Section(header: Text("Notification")) {
                ForEach(alarmSounds.notifications.allCases) { sound in
                    Button{
                        alarmSound = sound.rawValue
                        print(sound) // remove after debugging
                        
                        //TODO: Play audio
                        audioPlayer.playAudio()
                        
                    }label: {
                        HStack{
                            let name = "\(sound)"
                            Text(name)
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
                        print(sound) // remove after debugging
                        
                        //TODO: Play audio
                        audioPlayer.playAudio()
                        
                    }label: {
                        HStack{
                            let name = "\(sound)"
                            Text(name)
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
    }
}

struct alarmSounds {
    enum notifications: String, CaseIterable, Identifiable {
        case Note = "iPhone-Note-SMS.m4r"
        case Bell = "mixkit-bell-notification-933.wav"
        case Achievement = "mixkit-achievement-bell-600.wav"
        case Mystery = "mixkit-bells-of-mystery-581.wav"
        case Reward = "mixkit-correct-answer-reward-952.wav"
        case Happy = "mixkit-happy-bells-notification-937.wav"
        case DingDong = "mixkit-home-standard-ding-dong-109.wav"
        case Musical = "mixkit-musical-reveal-961.wav"
        case Higher = "mixkit-raising-me-higher-34.mp3"
        case SchoolBell = "mixkit-school-calling-bell-580.wav"
        
        var id: String { self.rawValue }
    }
    
    enum alarm: String, CaseIterable, Identifiable {
        case Dance = "mixkit-dance-with-me-3.mp3"
        case Dreaming = "mixkit-dreaming-big-31.mp3"
        case Retro = "mixkit-retro-game-emergency-alarm-1000.wav"
        
        var id: String {self.rawValue}
    }
}

//enum alarmSounds: String, CaseIterable, Identifiable {
//    case Note = "iPhone Note SMS.m4r"
//    case Bell = "mixkit-bell-notification-933.wav"
//    case Achievement = "mixkit-achievement-bell-600.wav"
//    case Mystery = "mixkit-bells-of-mystery-581.wav"
//    case Reward = "mixkit-correct-answer-reward-952.wav"
//    case Happy = "mixkit-happy-bells-notification-937.wav"
//    case DingDong = "mixkit-home-standard-ding-dong-109.wav"
//    case Musical = "mixkit-musical-reveal-961.wav"
//    case Higher = "mixkit-raising-me-higher-34.mp3"
//    case SchoolBell = "mixkit-school-calling-bell-580.wav"
//
//    case Dance = "mixkit-dance-with-me-3.mp3"
//    case Dreaming = "mixkit-dreaming-big-31.mp3"
//    case Retro = "mixkit-retro-game-emergency-alarm-1000.wav"
//
//    var id: String {self.rawValue}
//}
    

struct AlarmPicker_Previews: PreviewProvider {
    static var previews: some View {
        AlarmPicker()
            .environmentObject(AudioPlayer())
    }
}
