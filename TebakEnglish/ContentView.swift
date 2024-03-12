//
//  ContentView.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            HomePage()
        }
        .accentColor(ColorApp.primary)
    }
}

#Preview {
    ContentView()
        .environmentObject(ChallangesViewModel())
        .environmentObject(AppStateViewModel())
        .environmentObject(MyRecordsViewModel())
}
