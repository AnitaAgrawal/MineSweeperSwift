//
//  MineSweeperGameView.swift
//  MineSweeper
//
//  Created by Adi on 10/17/23.
//

import SwiftUI

struct MineSweeperGameView: View {
    var row: Int
    var column: Int
    private var columnLayout: [GridItem]
    private var gameHeart: MineSweeperCoreGame
    @State private var selectedIndex: Int = -1
    @State private var isShowingLost = false
    @State private var isShowingSuccess = false
    @State var board: [Character]
    
    let hepticFeedback = UINotificationFeedbackGenerator()
    let boardSize = UIScreen.main.bounds.width - 80
    
    init(gridRow: Int, gridColumn: Int) {
        row = gridRow
        column = gridColumn
        gameHeart = MineSweeperCoreGame(row: row, column: column)
        columnLayout = Array(repeating: GridItem(.flexible(), spacing: 0),
                             count: column)
        board = gameHeart.board
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            ScrollView {
                LazyVGrid(columns: columnLayout, spacing: 0) {
                    ForEach(0..<gameHeart.board.count, id:  \.description) { index in
                        Button {
                            selectedIndex = index
                            gameHeart.updateBoard(index)
                            board = gameHeart.board
                            if gameHeart.mineExploded(index) {
                                isShowingLost.toggle()
                                hepticFeedback.notificationOccurred(.error)
                            } else if gameHeart.hasSuccess() {
                                isShowingSuccess.toggle()
                                hepticFeedback.notificationOccurred(.success)
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .foregroundColor(MineCharacters.getColor(cell: index,
                                                                             column: column,
                                                                             char: board[index]))
                                if gameHeart.mineExploded(index) {
                                    Text("💥")
                                        .modifier(ConfettiModifier())
                                        .offset(x: 0, y: 0)
                                    Text("💥")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                } else {
                                    
                                    Text(gameHeart.getRevealedCellText(index))
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(gameHeart.getCellTextColor(index))
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .alert(isPresented: $isShowingLost) {
                            Alert(title: Text("Mine Exploded"),
                                  message: Text("💥💥💥"),
                                  primaryButton: .default(Text("Play again"), action: playAgain),
                                  secondaryButton: .destructive(Text("Dismiss")))
                            
                        }
                        .sheet(isPresented: $isShowingSuccess) {
                            self.playAgain()
                        } content: {
                            SuccessView()
                        }
                    }
                }
            }
        }
        .padding(10)
    }
    
    func playAgain() {
        gameHeart.playAgain()
        board = gameHeart.board
    }
}


struct MineSweeperGameView_previews: PreviewProvider {
    static var previews: some View {
        MineSweeperGameView(gridRow: 6, gridColumn: 6)
    }
}
