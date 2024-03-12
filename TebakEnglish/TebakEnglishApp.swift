//
//  TebakEnglishApp.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI

@main
struct TebakEnglishApp: App {
    
    @StateObject var appStateViewModel = AppStateViewModel()
    @StateObject var challangesViewModel = ChallangesViewModel()
    @StateObject var myRecordsViewModel = MyRecordsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appStateViewModel.restartApp {
                    ContentView()
                        .environmentObject(challangesViewModel)
                        .environmentObject(appStateViewModel)
                        .environmentObject(myRecordsViewModel)
                }
            }
        }
    }
}
