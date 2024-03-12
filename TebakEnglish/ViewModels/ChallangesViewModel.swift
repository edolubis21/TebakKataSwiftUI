//
//  ChallangesViewModel.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import Foundation
import SwiftUI

class ChallangesViewModel: ObservableObject {
    
    @Published var challanges: Challanges?
    @Published var isSelect: SelectGuessWord = SelectGuessWord.none
    @Published var selected: ChallangeModel? = nil
    @Published var status: StatusGuessWord = StatusGuessWord.none
    @Published var indexLeftSelected: Int? = nil
    @Published var indexRightSelected: Int? = nil
    @Published var combo = 0
    var previousCorrect = false
    @Published var seconds = 0
    @Published var correctCount = 0
    @Published var correctCountTotal = 0
    
    func beatSecond() {
        seconds += 1
    }
    
    func getChallanges(level: Int) {
        correctCount = 0
        challanges = loadLocalJson("data_\(level-1).json")
        challanges?.lefts.shuffle()
        challanges?.rights.shuffle()
    }
    
    
    func onGuessRight(value: ChallangeModel, index: Int) {
        if selected != nil {
            indexRightSelected = index
            let indexLeft = indexLeftSelected
            if selected?.idMatch == value.id {
                correctCount += 1
                correctCountTotal += 1
                status = .correct
                
                if correctCount < 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            if let indexLeft = indexLeft {
                                self.challanges?.lefts[indexLeft].isCorrect = true
                            }
                            self.challanges?.rights[index].isCorrect = true
                        }
                        
                    }
                }
                
        
                
                if previousCorrect {
                    combo += 1
                }
                previousCorrect = true
                
            } else {
                combo = 0
                status = .wrong
                previousCorrect = false
            }
            isSelect = .none
            selected = nil
            
        } else {
            indexRightSelected = index
            selected = value
            isSelect = .right
        }
        
    }
    
    func onGuessLeft(value: ChallangeModel, index: Int) {
        if selected != nil {
            indexLeftSelected = index
            let indexRight = indexRightSelected
            if selected?.idMatch == value.id {
                correctCount += 1
                correctCountTotal += 1
                status = .correct
                
                if correctCount < 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            self.challanges?.lefts[index].isCorrect = true
                            if let indexRight = indexRight  {
                                self.challanges?.rights[indexRight].isCorrect = true
                            }
                        }
                    }
                }
        
                
                if previousCorrect {
                    combo += 1
                }
                
                previousCorrect = true
            } else {
                combo = 0
                status = .wrong
                previousCorrect = false
            }
            isSelect = .none
            selected = nil
            
        } else {
            indexLeftSelected = index
            selected = value
            isSelect = .left
        }
        
    }
    
    func onResetStatus() {
        status = .none
    }
    
    func onReset() {
        challanges = nil
        isSelect = SelectGuessWord.none
        selected = nil
        status = StatusGuessWord.none
        indexLeftSelected = nil
        indexRightSelected = nil
        combo = 0
        previousCorrect = false
        seconds = 0
    }
    
}
