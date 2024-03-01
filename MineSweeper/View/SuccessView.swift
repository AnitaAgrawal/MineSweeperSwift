//
//  SuccessView.swift
//  MineSweeper
//
//  Created by Adi on 10/17/23.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        ZStack {
            Text("Congratulations")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.green)
            Text("🥳")
                .modifier(ConfettiModifier())
                .offset(x: -100, y: -60)
            Text("🎉")
                .modifier(ConfettiModifier())
                .offset(x: 70, y: 60)
        }
    }
}

struct SuccessView_previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
