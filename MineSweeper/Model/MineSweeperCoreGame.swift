//
//  MineSweeperCoreGame.swift
//  MineSweeper
//
//  Created by Adi on 10/17/23.
//

import SwiftUI

class MineSweeperCoreGame {
    var board: [Character] = []
    private var maxRowColumn: (row: Int, column: Int)
    private var noOfUnrevealedBlank = 0
    private var noOfMines = 0
    
    init(row: Int, column: Int) {
        maxRowColumn = (row - 1, column - 1)
        self.setUpBoard()
    }
    private func setUpBoard() {
        let max = (maxRowColumn.row + 1) * (maxRowColumn.column + 1)
        board = Array(repeating: MineCharacters.unrevealedBlank.rawValue,
                       count: max)
        for _ in 0...maxRowColumn.row {
            let random = Int(arc4random()) % max
            if board[random] != MineCharacters.unrevealedMine.rawValue {
                board[random] = MineCharacters.unrevealedMine.rawValue
                noOfMines += 1
            }
            
        }
        noOfUnrevealedBlank = max - noOfMines
    }
    func playAgain() {
        noOfUnrevealedBlank = 0
        noOfMines = 0
        setUpBoard()
    }
    
    func updateBoard(_ click: Int) {
        if hasMine(click) {
            board[click] = MineCharacters.revealedMine.rawValue
            return
        }
        var queue: Set<Int> = [click]
        while !queue.isEmpty {
            let cellIndex = queue.removeFirst()
            let (mines, cells) = getNoOfMinesAndUnrevealedAdjacentCells(cellIndex)
            if mines > 0 {
                board[cellIndex] = Character("\(mines)")
                noOfUnrevealedBlank -= 1
            } else {
                if board[cellIndex] != MineCharacters.revealedBlank.rawValue {
                    board[cellIndex] = MineCharacters.revealedBlank.rawValue
                    noOfUnrevealedBlank -= 1
                }
                   
                for cell in cells {
                    queue.insert(cell)
                }
            }
        }
    }
    func mineExploded(_ click: Int) -> Bool {
        board[click] == MineCharacters.revealedMine.rawValue
    }
    func hasSuccess() -> Bool {
        noOfUnrevealedBlank <= 0
    }
    func getRevealedCellText(_ click: Int) -> String {
        MineCharacters.getNumberOfMines(ch: board[click])
    }
    func getCellTextColor(_ click: Int) -> Color {
        MineCharacters.getMineNumberColor(ch: board[click])
    }
}

//MARK: - Helper function
extension MineSweeperCoreGame {
    private func hasMine(_ click: Int) -> Bool {
        board[click] == MineCharacters.unrevealedMine.rawValue ||
        board[click] == MineCharacters.revealedMine.rawValue
    }
    private func getRowBounds(_ click: Int) -> (Int, Int) {
        let row = click / (maxRowColumn.row + 1)
        let rowAbove = (row - 1) >= 0 ? (row - 1) : 0
        let rowBelow = (row + 1) <= maxRowColumn.row ? (row + 1) : row
        return (rowAbove, rowBelow)
    }
    private func getColumnBounds(_ click: Int) -> (Int, Int) {
        let column = click % (maxRowColumn.column + 1)
        let columnLeft = (column - 1) >= 0 ? (column - 1) : 0
        let columnRight = (column + 1) <= maxRowColumn.column ? (column + 1) : column
        return (columnLeft, columnRight)
    }
    fileprivate func getNoOfMinesAndUnrevealedAdjacentCells(_ click: Int) -> (Int, [Int]) {
        var mines = 0
        var cells = [Int]()
        let (rowAbove, rowBelow) = getRowBounds(click)
        let (columnLeft, columnRight) = getColumnBounds(click)
        
        for i in rowAbove...rowBelow {
            for j in columnLeft...columnRight {
                let cell = i * (maxRowColumn.row + 1) + j
                if hasMine(cell) {
                    mines += 1
                }
                if board[cell] == MineCharacters.unrevealedBlank.rawValue {
                    cells.append(cell)
                }
            }
        }
        return (mines, cells)
    }
}
