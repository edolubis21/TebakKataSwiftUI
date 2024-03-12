//
//  MyRecordsPage.swift
//  TebakEnglish
//
//  Created by edo lubis on 07/03/24.
//

import SwiftUI

struct MyRecordsPage: View {
    
    @EnvironmentObject var myRecordsViewModel: MyRecordsViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(levels.sorted(by: <), id: \.key) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Level \(item.key)")
                                .font(.system(size: 16, weight: .semibold))
                            Text("\(item.key * 5) pasangan")
                                .foregroundColor(Color(UIColor.lightGray))
                            
                        }
                        Spacer()
                        if let value = myRecordsViewModel.records[item.key] {
                            Text("\(formatTime(value))")
                                .font(.system(size: 16))
                        } else {
                            Text("-")
                                .font(.system(size: 16))
                        }
                    }
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Rekor Saya")
        .onAppear {
            myRecordsViewModel.getRecords()
        }
    }
}

#Preview {
    MyRecordsPage()
        .environmentObject(MyRecordsViewModel())
}
