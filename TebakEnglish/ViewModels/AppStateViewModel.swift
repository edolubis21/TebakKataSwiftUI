//
//  AppsViewModel.swift
//  TebakEnglish
//
//  Created by edo lubis on 11/03/24.
//

import Foundation

import Foundation

class AppStateViewModel: ObservableObject {
    @Published  var restartApp = true
    
    func onRestartApp() {
        restartApp = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.restartApp = true
        }
    }
}
