//
//  HomePage.swift
//  TebakEnglish
//
//  Created by edo lubis on 07/03/24.
//

import SwiftUI

struct HomePage: View {
    
    let maxLevel = 12
    
    @EnvironmentObject var myRecordsViewModel: MyRecordsViewModel
    
    @State var navigateToGueessPage = false
    @State var level: Int? = nil
    
    func getMaxLeverRecord() -> Int {
        let data = myRecordsViewModel.records.sorted(by: <)
        return data.last?.key ?? 0
    }
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: GuessPage(
                    params: GuessPageParams(level: level ?? 0)),
                isActive: $navigateToGueessPage,
                label: {}
            )
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(levels.sorted(by: <), id: \.key) { item in
                        if getMaxLeverRecord() + 1 == item.key {
                            PrimaryButton(
                                text: "Level \(item.key)",
                                maxWidth: .infinity,
                                onPressed: {
                                    level = item.key
                                    navigateToGueessPage.toggle()
                                },
                                foregroundColor: ColorApp.primary
                            )
                            .font(.system(size: 16,weight: .bold))
                        }
                        else if let _ = myRecordsViewModel.records[item.key] {
                            PrimaryButton(
                                text: "Level \(item.key)",
                                maxWidth: .infinity,
                                onPressed: {
                                    level = item.key
                                    navigateToGueessPage.toggle()
                                },
                                foregroundColor: ColorApp.primary
                            )
                            .font(.system(size: 16,weight: .bold))
                        } else {
                            PrimaryButton(
                                text: "Level \(item.key)",
                                maxWidth: .infinity,
                                onPressed: {
                                    level = item.key
                                    navigateToGueessPage.toggle()
                                },
                                foregroundColor: ColorApp.primary,
                                isLocked: myRecordsViewModel.records[item.key] == nil
                            )
                            .font(.system(size: 16,weight: .bold))
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    MyRecordsPage()
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                }
                
            }
        }
        .onAppear {
            myRecordsViewModel.getRecords()
        }
    }
}

#Preview {
    HomePage()
        .environmentObject(MyRecordsViewModel())
    
}
