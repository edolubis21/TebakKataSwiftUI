//
//  GuestPage.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import SwiftUI

struct GuessPage: View {
    
    @EnvironmentObject var challangesViewModel: ChallangesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading,spacing: 8) {
                Text("Ketuk Pasangan yang cocok")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text("KOMBO x0")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
            }
            .padding()
            Spacer()
            HStack {
                if challangesViewModel.challanges?.rights != nil {
                    VStack {
                        ForEach(challangesViewModel.challanges!.rights.indices, id: \.self) { index in
                            GuessButton(text: challangesViewModel.challanges!.rights[index].text, maxWidth: .infinity, onPressed: {
                                challangesViewModel.onGuessLeft(value: challangesViewModel.challanges!.lefts[index])
                            })
                                .padding()
                        }
              
                    }
                }
     
                if challangesViewModel.challanges?.lefts != nil {
                    VStack {
                        ForEach(challangesViewModel.challanges!.lefts.indices, id: \.self) { index in
                            PrimaryButton(text: challangesViewModel.challanges!.lefts[index].text, maxWidth: .infinity)
                                .padding()
                        }
              
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "clock")
                        .foregroundColor(ColorApp.primary)
                    Text("1:44")
                        .foregroundColor(.black)
                })
            }
        }
        .onAppear {
            challangesViewModel.getChallanges()
        }
    }
}


#Preview {
    NavigationView {
        GuessPage()
    }
    .environmentObject(ChallangesViewModel())
}
