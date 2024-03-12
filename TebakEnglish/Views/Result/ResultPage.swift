//
//  ResultPage.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI

struct ResultPage: View {
    
    let params: ResultPageParams
    
    @EnvironmentObject var myRecordsViewModel: MyRecordsViewModel
    @EnvironmentObject var appStateViewModel: AppStateViewModel
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Image("Splash Screen")
                .resizable()
                .renderingMode(.original)
                .opacity(0.7)
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Waktu")
                                .fontWeight(.semibold)
                                .foregroundColor(ColorApp.primary)
                            Spacer()
                            Text("\(formatTime(params.time))")
                                .fontWeight(.semibold)
                                .foregroundColor(ColorApp.primary)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10.0)
                        .padding()
                        
                        HStack {
                            Text("Total yang diselesaikan")
                                .fontWeight(.semibold)
                                .foregroundColor(ColorApp.primary)
                            Spacer()
                            Text("\(params.countFinish)")
                                .fontWeight(.semibold)
                                .foregroundColor(ColorApp.primary)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10.0)
                        .padding()
                    }
                    
                    VStack {
                        Spacer()
                        PrimaryButton(text: "SELESAI",maxWidth: .infinity, onPressed: {
                            appStateViewModel.onRestartApp()
                        },foregroundColor: ColorApp.primary)
                        .padding()
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                myRecordsViewModel.setRecords(data: [params.level : params.time])
            }
        }
        
    }
}

#Preview {
    NavigationView {
        ResultPage(params: ResultPageParams(time: 0, countFinish: 0, level: 1))
            .environmentObject(AppStateViewModel())
    }
}
