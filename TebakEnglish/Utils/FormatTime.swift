//
//  FormatTime.swift
//  TebakEnglish
//
//  Created by edo lubis on 07/03/24.
//

import Foundation

func formatStopwatch(_ seconds: Int) -> String {
    let minutes = seconds / 60
    let second = seconds % 60
    return "\(String(minutes).count == 1 ? "0" : "")\(minutes):\(String(second).count == 1 ? "0" : "")\(second)"
}

func formatTime(_ seconds: Int) -> String {
    let minutes = seconds / 60
    let second = seconds % 60
    
    if minutes == 0 {
        return "\(second) detik"
    }
    
    return "\(minutes) menit \(second) detik"
}
