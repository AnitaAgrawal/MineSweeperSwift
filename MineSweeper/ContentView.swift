//
//  ContentView.swift
//  MineSweeper
//
//  Created by Adi on 10/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            MineSweeperGameView(gridRow: 10,
                                gridColumn: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
