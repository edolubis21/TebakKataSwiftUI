//
//  GuessButton.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI

struct PrimaryButton: View {
    
    let text: String
    let maxWidth: CGFloat?
    let onPressed: () -> ()
    let foregroundColor: Color
    let isLocked: Bool
    
    init(text: String, maxWidth: CGFloat? = nil, onPressed: @escaping () -> () = {}, foregroundColor: Color = .black, isLocked: Bool = false) {
        self.text = text
        self.maxWidth = maxWidth
        self.onPressed = onPressed
        self.foregroundColor = foregroundColor
        self.isLocked = isLocked
    }
    
    var body: some View {
        Button {
            onPressed()
        } label: {
            
            
            ZStack {
                if isLocked {
                    HStack {
                        Text(text)
                        Image(systemName: "lock.fill")
                    }
                } else {
                    Text(text)
                }
                
            }
            .padding()
            .foregroundColor(foregroundColor)
            .frame(maxWidth: maxWidth)
            .background(isLocked ?  ColorApp.Platinum : Color.white)
            .cornerRadius(10)
            .shadow(color: ColorApp.Platinum, radius: 0, x: 0, y:  4)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ColorApp.Platinum, lineWidth: 1)
            )
            
            
        }
        .disabled(isLocked)
    }
}


#Preview {
    PrimaryButton(text: "Click Me")
}
