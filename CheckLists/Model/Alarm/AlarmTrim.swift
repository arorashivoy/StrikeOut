//
//  AlarmTrim.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 13/09/21.
//

import Foundation
import AVFoundation
import UniformTypeIdentifiers

struct AudioTrim {
    var audioURL: URL
    var nameExterntion: String
    
    var asset: AVURLAsset

    
    /// to trim the audio imported to be 30 sec if it is greater than that
    func trim() {
        /// Setting up export session
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough) else {return}
        
        exportSession.outputURL = audioURL
        
        if nameExterntion == "wav" {
            exportSession.outputFileType = .wav
        }else if nameExterntion == "aiff" {
            exportSession.outputFileType = .aiff
        }else {
            exportSession.outputFileType = .m4a
        }
        
        /// Setting audio file duration
        let start = 0
        let end = 30
        let length = Float(asset.duration.value) / Float(asset.duration.timescale)
        
        let startTimeRange = CMTime(seconds: Double(start), preferredTimescale: 1000)
        let endTimeRange = CMTime(seconds: Double(min(Float(end), length)), preferredTimescale: 1000)
        let timeRange = CMTimeRange(start: startTimeRange, end: endTimeRange)
        
        exportSession.timeRange = timeRange
        
        /// removing file
        try? FileManager.default.removeItem(at: audioURL)
        
        /// Exporting
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                print("Exported at \(audioURL)\nsuccesfully trimed")
            case .failed:
                print("failed\n \(String(describing: exportSession.error))")
            case .cancelled:
                print("cancelled\n \(String(describing: exportSession.error))")
            default:
                break
            }
        }
    }
    
}
