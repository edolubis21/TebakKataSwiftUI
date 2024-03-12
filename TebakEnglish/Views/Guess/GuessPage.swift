//
//  GuestPage.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI
import Combine

struct GuessPage: View {
    
    @EnvironmentObject var challangesViewModel: ChallangesViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var navigateToResult = false
    @State var currentLevel: Int
    
    @StateObject var timerManager = TimerManager()
    
    let params: GuessPageParams
    
    init (params: GuessPageParams) {
        self.params = params
        _currentLevel = State(initialValue: levels[params.level] ?? 1)
    }
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: ResultPage(
                    params: ResultPageParams(
                        time: challangesViewModel.seconds,
                        countFinish: challangesViewModel.correctCount,
                        level: params.level
                    )
                ),
                isActive: $navigateToResult,
                label: {
                    
                })
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading,spacing: 8) {
                    Text("Ketuk Pasangan yang cocok")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("KOMBO x\(challangesViewModel.combo)")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                }
                .padding()
                Spacer()
                HStack(spacing: 24) {
                    if let lefts = challangesViewModel.challanges?.lefts {
                        VStack(spacing: 24) {
                            ForEach(lefts.indices, id: \.self) { index in
                                GuessButton(
                                    text: lefts[index].text,
                                    maxWidth: .infinity,
                                    onPressed: {
                                        challangesViewModel.onGuessLeft(
                                            value: lefts[index],
                                            index: index
                                        )
                                    },
                                    isDisable: challangesViewModel.isSelect == SelectGuessWord.left,
                                    isSelected: lefts[index] == challangesViewModel.selected,
                                    status: index == challangesViewModel.indexLeftSelected ? challangesViewModel.status : .none,
                                    afterAnimation: {
                                        challangesViewModel.onResetStatus()
                                    }
                                )
                                .id(index)
                                .padding(.leading, 24)
                                .opacity(lefts[index].isCorrect ? 0 : 1)
                                .disabled(lefts[index].isCorrect)
                            }
                            
                        }
                    }
                    
                    if let rights = challangesViewModel.challanges?.rights {
                        VStack(spacing: 24)  {
                            ForEach(rights.indices, id: \.self) { index in
                                GuessButton(
                                    text: rights[index].text,
                                    maxWidth: .infinity,
                                    onPressed: {
                                        challangesViewModel.onGuessRight(
                                            value: rights[index] ,
                                            index: index
                                        )
                                    },
                                    isDisable: challangesViewModel.isSelect == SelectGuessWord.right,
                                    isSelected: rights[index] == challangesViewModel.selected,
                                    status: index == challangesViewModel.indexRightSelected ? challangesViewModel.status : .none,
                                    afterAnimation: {
                                        challangesViewModel.onResetStatus()
                                    }
                                )
                                .id(index)
                                .padding(.trailing, 24)
                                .opacity(rights[index].isCorrect ? 0 : 1)
                                .disabled(rights[index].isCorrect)
                            }
                            
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "clock")
                            .foregroundColor(ColorApp.primary)
                        Text("\(formatStopwatch(challangesViewModel.seconds))")
                            .foregroundColor(.black)
                            .frame(width: 55)
                    })
                }
            }
            .onAppear {
                timerManager.start {
                    challangesViewModel.beatSecond()
                }
                challangesViewModel.onReset()
                challangesViewModel.getChallanges(level: currentLevel)
            }
            .onChange(of: challangesViewModel.correctCount) { value in
                if value >= 5 {
                    if goToNextStage(currentStage: currentLevel) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            currentLevel += 1
                            challangesViewModel.getChallanges(level: currentLevel)
                        }
                    } else {
                        navigateToResult.toggle()
                    }
                    
                }
                
            }
            .onDisappear {
                timerManager.stop()
            }
        }
        
    }
}


#Preview {
    NavigationView {
        GuessPage(params: GuessPageParams(level: 1))
    }
    .environmentObject(ChallangesViewModel())
    .environmentObject(MyRecordsViewModel())
}
