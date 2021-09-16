//
//  AudioImport.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 13/09/21.
//

import Foundation
import AVFoundation
import SwiftUI

struct AlarmImport {
    
    /// library folder
    private static var libraryFolder: URL {
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
    static var soundURL: URL {
        let soundURL = libraryFolder.appendingPathComponent("Sounds")
        
        do {
            try FileManager.default.createDirectory(at: soundURL, withIntermediateDirectories: true, attributes: nil)
        }catch{
            print("\n\nUnable to create directory\n\(error)")
        }
        
        return soundURL
    }
    
    
    /// to copy the file that was selected in to fileImporter to the sounds library
    /// - Parameter audioURL: url of the file selected by fileImporter
    func copyAudioFile(of audioURL: URL) {
        
        /// To check whether the file already exist
        var audioName: String = audioURL.lastPathComponent
        var audioPath = AlarmImport.soundURL.path + "/\(audioName)"
        
        /// To change name if the file already exists
        let nameExtension = audioURL.lastPathComponent.split(separator: ".")
        
        var num = 1
        
        while FileManager.default.fileExists(atPath: audioPath) {
            audioName = "\(nameExtension[0]) (\(num)).\(nameExtension[1])"
            audioPath = AlarmImport.soundURL.path + "/\(audioName)"
            
            num += 1
        }
        
        let outputURL = AlarmImport.soundURL.appendingPathComponent(audioName)
        
        /// Copying File
        do {
            try FileManager.default.copyItem(at: audioURL, to: outputURL)

            print("sucessfully copied")
        }catch {
            fatalError("Unable to copy file \n \(error)")
        }
        
        /// Setting the url name
        AlarmModel.shared.audioName = audioName
        print(AlarmModel.shared.audioName)
        
        /// Trim audio
        AudioTrim(audioURL: outputURL, nameExterntion: String(nameExtension[1]), asset: AVURLAsset(url: outputURL, options: [AVURLAssetPreferPreciseDurationAndTimingKey : true])).trim()
    }
}

