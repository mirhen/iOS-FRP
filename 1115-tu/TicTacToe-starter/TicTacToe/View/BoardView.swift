//
//  BoardView.swift
//  TicTacToe
//
//  Created by Nikolas Burk on 05/10/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

fileprivate let numberOfRows: CGFloat = 3
fileprivate let numberOfColumns: CGFloat = 3

protocol BoardViewDelegate {
  
  func tappedField(xPosition: Int, yPosition: Int)
  
}

class BoardView: UIView {
  
  var delegate: BoardViewDelegate?
  var fields: [FieldView] = []
  
  convenience init(boardWidth: CGFloat, boardHeight: CGFloat) {
    let fieldWidth = boardWidth / numberOfColumns
    let fieldHeight = boardHeight / numberOfRows
    self.init(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
  }
  
  init(fieldWidth: CGFloat, fieldHeight: CGFloat) {
    
    // initialise the view
    let boardFrame = CGRect(x: 0, y: 0, width: numberOfColumns*fieldWidth, height: numberOfRows*fieldHeight)
    super.init(frame: boardFrame)
    
    // add the fields
    let numberOfFields = Int(numberOfRows*numberOfColumns)
    for i in 0..<numberOfFields {
      
      // calculate x and y positions for the current field
      let xPosition = i % Int(numberOfColumns)
      let x = CGFloat(xPosition) * fieldWidth
      let yPosition = i / Int(numberOfRows)
      let y = CGFloat(yPosition) * fieldHeight
      let currentFieldFrame = CGRect(x: x, y: y, width: fieldWidth, height: fieldHeight)
      let field = FieldView(frame: currentFieldFrame, xPosition: xPosition, yPosition: yPosition)
      field.layer.borderWidth = 1.0

      // add a gesture recognizer to the field
      let tap = UITapGestureRecognizer(target: self, action: #selector(BoardView.handleTap(_:)))
      field.addGestureRecognizer(tap)
      
      // add the field as subview to our board
      self.addSubview(field)
      fields.append(field)
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func handleTap(_ tap: UITapGestureRecognizer) {
    let tappedField = tap.view as! FieldView
    delegate?.tappedField(xPosition: tappedField.xPosition, yPosition: tappedField.yPosition)
  }
  
  func updateFieldAtPosition(player: Player, xPosition: Int, yPosition: Int) {
    let index = yPosition*Int(numberOfRows) + xPosition
    fields[index].state = player == .cross ? .x : .o
  }
  
  func clearFieldAtPosition(xPosition: Int, yPosition: Int) {
    let index = yPosition*Int(numberOfRows) + xPosition
    fields[index].state = .empty
  }
  
  func resetAllFieldsToEmpty() {
    let _ = fields.map {
      $0.state = .empty
    }
  }
  
  
}





