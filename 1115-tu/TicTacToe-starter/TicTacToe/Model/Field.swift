//
//  Field.swift
//  TicTacToe
//
//  Created by Nikolas Burk on 05/10/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation

enum Field {
  case free
  case hasPlayer(Player)
}

// we need to implement equatable because we are using enums with associated values
extension Field: Equatable {
  
}

func ==(lhs: Field, rhs: Field) -> Bool {
  switch (lhs, rhs) {
  case (.free, .free):
    return true
  case (let .hasPlayer(player1), let .hasPlayer(player2)):
    return player1 == player2
  default:
    return false // one of the fields is free, the other has a player
  }
}

