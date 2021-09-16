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
    @AppStorage(StorageString.alarmSound.rawValue) var alarmSound: String = AlarmModel.notifications.Note.rawValue
    
    /// Publisher
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var audioPlayer: AVAudioPlayer!
    
    var playing = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    
    /// Play audio stored in the bundle
    func playAudioBundle() {
        
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
        let defName = AlarmModel.notifications.Note.rawValue.split(separator: ".")
        
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
    
    /// play audio stored in the ~/Library/Sounds
    func playAudioLibrary() {
        
        ///  Setting up session
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.setCategory(.playback, mode: .default)
            try playSession.setActive(true)
        }catch {
            print("Failed to set up playing session")
        }
        
        /// Finding URL of file
        ///
        /// library folder
        var libraryFolder: URL {
            do {
                return try FileManager.default.url(for: .libraryDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            }catch{
                fatalError("Can't find /Library/Sound folder")
            }
        }
        
        /// sounds url
        var soundFolder: URL {
            let soundFolder = libraryFolder.appendingPathComponent("Sounds")
            
            do {
                try FileManager.default.createDirectory(at: soundFolder, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("\n\nUnable to create directory\n\(error)")
            }
            
            return soundFolder
        }
        
        let soundURL: URL = soundFolder.appendingPathComponent(alarmSound)
        
        /// Playing
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.play()
            
            playing = true
        }catch {
            print("Couldn't load player")
        }
    }
    
    /// Stop playing
    func stopAudio() {
        
        if playing {
            audioPlayer.stop()
        }
        
        playing = false
    }
}
