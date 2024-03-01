//
//  MineCharacters.swift
//  MineSweeper
//
//  Created by Adi on 10/13/23.
//

import SwiftUI

enum MineCharacters: Character {
    case unrevealedMine = "M"
    case revealedMine = "X"
    case unrevealedBlank = "E"
    case revealedBlank = "B"
    
    static func getColor(cell: Int, column: Int, char: Character) -> Color {
        let isEven = (cell + cell / column) % 2 == 0
        switch char {
        case "X":
            return .black
        case "B":
            return isEven ? Color.revealedBrownLight : Color.revealedBrownDark
        case "M", "E":
            return isEven ? Color.unrevealedGreenLight : Color.urevealedGreenDark
        default:
            return isEven ? Color.revealedBrownLight : Color.revealedBrownDark
        }
    }
    
    static func getNumberOfMines(ch: Character) -> String {
        ("1"..."8").contains(ch) ? "\(ch)" : ""
    }
    
    static func getMineNumberColor(ch: Character) -> Color {
        [Color.blue,
            .indigo,
            .pink,
            .red,
            .green,
            .mint,
            .cyan,
            .teal,
            .purple][Int("\(ch)") ?? 0]
    }
}
