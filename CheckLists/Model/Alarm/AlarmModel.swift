//
//  AlarmModel.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 13/09/21.
//

import Foundation
import Combine
import SwiftUI

class AlarmModel: ObservableObject {
    
    /// Creating a shared instance
    static let shared = AlarmModel()
    
    @Published var customAlarms: [CustomAlarm] = []
    
    @Published var audioName: String = ""
    var fileName: String = "CustomTonesNames.json"
    
    /// To get documents folder
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    /// To get saved file url
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent(AlarmModel().fileName)
    }
    
    /// to load data
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                DispatchQueue.main.async {
                    self?.customAlarms = []
                }
                return
            }
            guard let lists = try? JSONDecoder().decode([CustomAlarm].self, from: data) else {
                fatalError("Can't decode saved Lists data.")
            }
            DispatchQueue.main.async {
                self?.customAlarms = lists
            }
        }
    }
    
    /// to save data
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let customAlarms = self?.customAlarms else { fatalError("self is out of scope") }
            guard let data = try? JSONEncoder().encode(customAlarms) else { fatalError("Error encoding data") }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
    /// Notification Sounds Name
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
    
    /// Alarm Sounds Name
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


/// Structure for the cutom sounds added
/// For encoding and decoding json
struct CustomAlarm: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var url : String
}
