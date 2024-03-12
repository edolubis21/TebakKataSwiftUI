//
//  GoToNextStage.swift
//  TebakEnglish
//
//  Created by edo lubis on 07/03/24.
//

import Foundation

let levels: [Int:Int] = [1:1, 2:2, 3:4, 4:7, 5:11, 6:16, 7:22, 8:29, 9:37, 10:46, 11:56, 12:67]

func goToNextStage(currentStage: Int) ->Bool {
    
    if currentStage == 1 || currentStage == 3 || currentStage == 6 || currentStage == 10 ||   currentStage == 15 ||  currentStage == 21 || currentStage == 28 || currentStage == 36 || currentStage == 45 ||   currentStage == 55 || currentStage == 66 ||   currentStage == 78   {
        return false
    }
    
    
    return true
}
