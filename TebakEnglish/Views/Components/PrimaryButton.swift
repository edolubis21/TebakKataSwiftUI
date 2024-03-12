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
    
    init(text: String, maxWidth: CGFloat? = nil ) {
        self.text = text
        self.maxWidth = maxWidth
    }
    
    var body: some View {
        Button {
            
        } label: {
            Text(text)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: maxWidth)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: ColorApp.Platinum, radius: 0, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(ColorApp.Platinum, lineWidth: 1)
                )
           
        }
    }
}

#Preview {
    PrimaryButton(text: "Click Me")
}
