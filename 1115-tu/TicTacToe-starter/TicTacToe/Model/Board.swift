//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Nikolas Burk on 04/10/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation
import RxSwift

typealias Move = (Player, Int, Int)

struct Board {
  fileprivate let numberOfAllowedMoves = 3 // extra rule
  fileprivate var currentTurn: Player = .cross
  fileprivate var recordedMoves: [Move] = []
  var fields: [[Field]] = [[.free, .free, .free], [.free, .free, .free], [.free, .free, .free]]
}


// MARK: Board functionality

extension Board {
  
  
  // MARK: Public API
  
  func playerWithCurrentTurn() -> Player {
    switch currentTurn {
    case .cross:
      return .circle
    case .circle:
      return .cross
    }
  }
  
  mutating func updatePlayerWithCurrentTurn() {
    switch currentTurn {
    case .cross:
      currentTurn = .circle
    case .circle:
      currentTurn = .cross
    }
  }
  
  // returns move that needs to be removed
  mutating func move(player: Player, x: Int, y: Int) -> (Int, Int)? {
    assert(x < 3 && y < 3, "can only make moves up to three")
    assert((fields[y][x] == .free), "can't make a move to \(x),\(y) as it is already occupied: \(fields[x][y])")
    fields[y][x] = .hasPlayer(player)
    
    // record move
    let newMove: Move = (player, x, y)
    recordedMoves.append(newMove)
    let movesFromCurrentPlayer = recordedMoves.filter { (move: Move) in
      return move.0 == player
    }
    
    // remove previous move if necessary
    if movesFromCurrentPlayer.count > numberOfAllowedMoves {
      let moveToRemove = removeFirstMoveForPlayer(player: player)
      return moveToRemove
    }
    return nil
  }
  
  func winner() -> Player? {
    if let winner = checkRowsForWinner() {
      return winner
    }
    if let winner = checkColumnsForWinner() {
      return winner
    }
    if let winner = checkDiagonalsForWinner() {
      return winner
    }
    return nil
  }
  
  func name(for player: Player) -> String {
    switch player {
    case .circle:
      return "O"
    case .cross:
      return "X"
    }
  }
  
  
  // MARK: Private helper functions
  
  private mutating func removeFirstMoveForPlayer(player: Player) -> (Int, Int)? {
    guard recordedMoves.count >= 2 else {
      print("not enough moves to remove a player")
      return nil
    }
    var moveToRemove: Move
    if recordedMoves[0].0 == player {
      moveToRemove = recordedMoves[0]
      fields[moveToRemove.2][moveToRemove.1] = .free
      recordedMoves.remove(at: 0)
    }
    else if recordedMoves[1].0 == player {
      moveToRemove = recordedMoves[1]
      fields[moveToRemove.2][moveToRemove.1] = .free
      recordedMoves.remove(at: 1)
    }
    else {
      return nil
    }
    return (moveToRemove.1, moveToRemove.2)
  }
  
  private func checkRowsForWinner() -> Player? {
    let firstRow = fields[0]
    let secondRow = fields[1]
    let thirdRow = fields[2]
    
    if checkWinner(in: firstRow, for: .cross) {
      return .cross
    }
    if checkWinner(in: secondRow, for: .cross) {
      return .cross
    }
    if checkWinner(in: thirdRow, for: .cross) {
      return .cross
    }
    if checkWinner(in: firstRow, for: .circle) {
      return .circle
    }
    if checkWinner(in: secondRow, for: .circle) {
      return .circle
    }
    if checkWinner(in: thirdRow, for: .circle) {
      return .circle
    }
    return nil
  }

  private func checkColumnsForWinner() -> Player? {
    let firstColum = [fields[0][0],  fields[1][0],  fields[2][0]]
    let secondColum = [fields[0][1],  fields[1][1],  fields[2][1]]
    let thirdColum = [fields[0][2],  fields[1][2],  fields[2][2]]
    
    if checkWinner(in: firstColum, for: .cross) {
      return .cross
    }
    if checkWinner(in: secondColum, for: .cross) {
      return .cross
    }
    if checkWinner(in: thirdColum, for: .cross) {
      return .cross
    }
    if checkWinner(in: firstColum, for: .circle) {
      return .circle
    }
    if checkWinner(in: secondColum, for: .circle) {
      return .circle
    }
    if checkWinner(in: thirdColum, for: .circle) {
      return .circle
    }
    return nil
  }
  
  private func checkDiagonalsForWinner() -> Player? {
    let firstDiagonal = [fields[0][0],  fields[1][1],  fields[2][2]]
    let secondDiagonal = [fields[0][2],  fields[1][1],  fields[2][0]]
    if checkWinner(in: firstDiagonal, for: .cross) {
      return .cross
    }
    if checkWinner(in: secondDiagonal, for: .cross) {
      return .cross
    }
    if checkWinner(in: firstDiagonal, for: .circle) {
      return .circle
    }
    if checkWinner(in: secondDiagonal, for: .circle) {
      return .circle
    }
    return nil

  }
  
  private func checkWinner(in fields: [Field], for player: Player) -> Bool {
    if fields[0] == .hasPlayer(player) && fields[1] == .hasPlayer(player) && fields[2] == .hasPlayer(player) {
      return true
    }
    return false
  }

}


// MARK: ObservableType implementation

extension Board: ObservableType, Disposable {
  
  typealias E = Board
  
  func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
    
    return self
  }
  
  func dispose() {
    print(#function)
  }
  
}
