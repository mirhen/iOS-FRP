//
//  ViewController.swift
//  TicTacToe
//
//  Created by Nikolas Burk on 04/10/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController, BoardViewDelegate {
  
  var board: Variable<Board> = Variable(Board()) //Board() // model
  weak var boardView: BoardView! // view

  @IBOutlet var currentTurnLabel: UILabel!
  @IBOutlet weak var turnInfoLabel: UILabel!
  
  private var disposeBag = DisposeBag()
  
  
  // MARK: View controller lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create board view and add it as a subview
    addBoardView()
    setupBoardObserver()
    
    // update UI for initial turn
    currentTurnLabel.text = board.value.name(for: board.value.playerWithCurrentTurn())
  }
  
  func tappedField(xPosition: Int, yPosition: Int) {
    print("\(xPosition), \(yPosition) tapped")
    let playerWithCurrenTurn = board.value.playerWithCurrentTurn()
    
    // update model and view
    if let moveToRemove = board.value.move(player: playerWithCurrenTurn, x: xPosition, y: yPosition) {
      boardView.clearFieldAtPosition(xPosition: moveToRemove.0, yPosition: moveToRemove.1)
    }
    boardView.updateFieldAtPosition(player: playerWithCurrenTurn, xPosition: xPosition, yPosition: yPosition)
    
    // check for winner
    if let winner = board.value.winner() {
      print("winner is: \(winner)")
      boardView.isUserInteractionEnabled = false
      turnInfoLabel.text = "Winner:"
      currentTurnLabel.text = board.value.name(for: winner)
    }
    else {
      board.value.updatePlayerWithCurrentTurn()
      currentTurnLabel.text = board.value.name(for: board.value.playerWithCurrentTurn())
    }
  
  }
  
  @IBAction func restartButtonPressed(_ sender: AnyObject) {
    board.value = Board()
    turnInfoLabel.text = "Current turn:"
    boardView.resetAllFieldsToEmpty()
    boardView.isUserInteractionEnabled = true
    currentTurnLabel.text = board.value.name(for: board.value.playerWithCurrentTurn())
  }


  
  // MARK: Helpers
  
  private func addBoardView() {
    let margin = 20
    let boardLength = view.bounds.width - CGFloat(2*margin)
    let boardView = BoardView(boardWidth: boardLength, boardHeight: boardLength)
    boardView.center = view.center
    view.addSubview(boardView) // now the view is another owner of the boardView
    self.boardView = boardView
    boardView.delegate = self
  }
  
  private func setupBoardObserver() {
    board.asObservable().subscribe(onNext: { (board: Board) in
      print("board changed")
    }).addDisposableTo(disposeBag)
    
    
  }
  
}



