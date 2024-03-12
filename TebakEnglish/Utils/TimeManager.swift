//
//  TimeManager.swift
//  TebakEnglish
//
//  Created by edo lubis on 11/03/24.
//


import Foundation
import Combine

class TimerManager: ObservableObject {
    
    private var timer: AnyCancellable?
    
    func start(callback: @escaping () -> Void) {
        stop()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                callback()
            }
    }
    
    func stop() {
        self.timer?.cancel()
    }
}
