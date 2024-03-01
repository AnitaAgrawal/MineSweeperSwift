//
//  LostView.swift
//  MineSweeper
//
//  Created by Adi on 10/17/23.
//

import SwiftUI

struct LostView: View {
    
    var body: some View {
        ZStack {
            Text("Mine Exploded 💥")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            Text("💥")
                .modifier(ConfettiModifier())
                .offset(x: -100, y: -60)
            Text("🔥")
                .modifier(ConfettiModifier())
                .offset(x: 70, y: 60)
        }
    }
}

struct LostView_Previews: PreviewProvider {
    static var previews: some View {
        LostView()
    }
}
