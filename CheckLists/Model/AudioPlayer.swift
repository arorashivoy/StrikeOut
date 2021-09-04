//
//  AudioPlayer.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 04/09/21.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class AudioPlayer: ObservableObject {
    @AppStorage("alarmSound") var alarmSound: String = alarmSounds.notifications.Note.rawValue
    
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var audioPlayer: AVAudioPlayer!
    
    var playing = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func playAudio() {
        
        /// Setting up session
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.setCategory(.playback, mode: .default)
            try playSession.setActive(true)
        }catch {
            print("Failed to setup playing session")
        }
        
        /// finding url of file
        let soundName = alarmSound.split(separator: ".")
        let defName = alarmSounds.notifications.Note.rawValue.split(separator: ".")
        
        let soundURL: URL = Bundle.main.url(forResource: String(soundName[0]), withExtension: String(soundName[1])) ?? Bundle.main.url(forResource: String(defName[0]), withExtension: String(defName[1]))!
        
        /// Playing
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.play()
            
            playing = true
        }catch {
            print("Couldn't load player")
        }
    }
    
    func stopAudio() {
        
        if playing {
            audioPlayer.stop()
        }
        
        playing = false
    }
}
