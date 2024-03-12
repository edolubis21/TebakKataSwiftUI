//
//  GuessButton.swift
//  TebakEnglish
//
//  Created by edo lubis on 05/03/24.
//

import SwiftUI

struct GuessButton: View {
    
    let text: String
    let maxWidth: CGFloat?
    let onPressed: () -> ()
    let foregroundColor: Color
    let isDisable: Bool
    let isSelected: Bool
    let status: StatusGuessWord
    let afterAnimation: () -> ()
    
    @State var isAnimate = false
    
    init(text: String, maxWidth: CGFloat? = nil, onPressed: @escaping () -> () = {}, foregroundColor: Color = .black, isDisable: Bool = false, isSelected: Bool = false, status: StatusGuessWord = .none, afterAnimation: @escaping () -> () = {}) {
        self.text = text
        self.maxWidth = maxWidth
        self.onPressed = onPressed
        self.foregroundColor = foregroundColor
        self.isDisable = isDisable
        self.isSelected = isSelected
        self.status = status
        self.afterAnimation = afterAnimation
    }
    
    func getColorBackground()-> Color {
        if isAnimate {
            if status == StatusGuessWord.correct{
                return Color.green.opacity(0.8)
            }
            if status == StatusGuessWord.wrong{
                return Color.red.opacity(0.8)
            }
        }
        return Color.white
    }
    
    func getForegroundColor()-> Color {
        if isAnimate {
            return Color.white
        }
        return foregroundColor
        
    }
    
    func getShadowColor() -> Color {
        if isSelected || isAnimate {
            return Color.clear
        }
        return ColorApp.Platinum
    }
    
    func getShadowAnimationColor() -> Color {
        if isAnimate {
            if status == StatusGuessWord.correct{
                return Color.green.opacity(0.8)
            }
            if status == StatusGuessWord.wrong{
                return Color.red.opacity(0.8)
            }
        }
        return Color.clear
    }
    
    var body: some View {
        Button {
            if !isAnimate {
                onPressed()
            }
        } label: {
            Text(text.capitalized)
                .padding()
                .foregroundColor(getForegroundColor())
                .frame(maxWidth: maxWidth)
                .background(getColorBackground())
                .cornerRadius(10)
                .shadow(color: getShadowColor(), radius: 0, x: 0, y: 4)
                .shadow(color: getColorBackground(), radius: 10, x: 0, y:  0)
                .overlay(
                    Group {
                        if !isAnimate {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(ColorApp.Platinum, lineWidth: 1)
                        }
                    }
                )
                .opacity(isSelected ? 0.6 : 1)
       
        }
        .disabled(isDisable)
        .onChange(of: status) { newValue in
            if newValue != .none {
                if !isAnimate {
                    isAnimate = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isAnimate = false
                        afterAnimation()
                    }
                }
            }
         
        }
        
    }
}

#Preview {
    GuessButton(text: "Click Me")
}
